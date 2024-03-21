import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_project/apis/create_transaction_api.dart';
import 'package:new_project/apis/update_transtion.dart';
import 'package:new_project/common/widgets/toasts.dart';
import 'package:new_project/models/create_transaction_model.dart';
import 'package:new_project/models/update_transaction_model.dart';
import 'package:new_project/utils/color_res.dart';
import 'package:new_project/utils/string_res.dart';
import 'package:new_project/utils/text_styles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SearchResultController extends GetxController {
  final String? id;

  SearchResultController({this.id});

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isScanHandled = false;
  Barcode? result;
  String selectedData = '';
  bool isBarcode = false;
  RxBool loader = false.obs;
  int initialIndex = 0;
  List<String> statusList = List.generate(14, (index) => '');
  List<File> imageFileList = List.generate(14, (index) => File(''));
String orgid ='';
  List barcodeData = [
    {
      'name': 'l1',
      'image': '',
      "value": '',
    },
    {
      'name': 'l2',
      'image': '',
      "value": '',
    },
    {
      'name': 'l3',
      'image': '',
      "value": '',
    },
    {
      'name': 'l4',
      'image': '',
      "value": '',
    },
    {
      'name': 'l5',
      'image': '',
      "value": '',
    },
    {
      'name': 'r1',
      'image': '',
      "value": '',
    },
    {
      'name': 'r2',
      'image': '',
      "value": '',
    },
    {
      'name': 'r3',
      'image': '',
      "value": '',
    },
    {
      'name': 'r4',
      'image': '',
      "value": '',
    },
    {
      'name': 'r5',
      'image': '',
      "value": '',
    },
    {
      'name': 'f1',
      'image': '',
      "value": '',
    },
    {
      'name': 'f2',
      'image': '',
      "value": '',
    },
    {
      'name': 'b1',
      'image': '',
      "value": '',
    },
    {
      'name': 'b2',
      'image': '',
      "value": '',
    },
  ];
  List<String> barcodeDataImage = List.generate(14, (index) => '');
  List byteImageList = List.generate(14, (index) => []);
  CreateTransactionModel createTransactionModel = CreateTransactionModel();
  List<File> materialPhotoList = List.generate(1, (index) => File(''));

  File devicePhoto1 = File('');
  File devicePhoto2 = File('');

  @override
  void onInit() {
    // if (id != null) {
    //   createTransactionAPi();
    // }
    super.onInit();
  }

  materialPhotoAPi() async {
    for (int i = 0; i < materialPhotoList.length; i++) {
      if (materialPhotoList[i].path.isNotEmpty) {
        Uint8List imageBytes = await materialPhotoList[i].readAsBytes();
        String base64String = base64Encode(imageBytes);
        Map map = {'mp${i + 1}': base64String};
        await updateTransactionAPi(map);

        update(['qr']);
      } else {}
    }
  }

  devicePhotoApi() async {
    if (devicePhoto1.path.isNotEmpty) {
      Uint8List imageBytes = await devicePhoto1.readAsBytes();
      String base64String = base64Encode(imageBytes);
      Map map = {'dp1': base64String};
      await updateTransactionAPi(map);
    } else {}
    if (devicePhoto2.path.isNotEmpty) {
      Uint8List imageBytes = await devicePhoto2.readAsBytes();
      String base64String = base64Encode(imageBytes);
      Map map = {'dp2': base64String};
      await updateTransactionAPi(map);
    } else {}

    update(['qr']);
  }

  validation() {
    if (devicePhoto1.path.isEmpty || devicePhoto2.path.isEmpty) {
      errorToast('Please select 2 device photos');
    } else if (materialPhotoList[0].path.isEmpty) {
      errorToast('Please select atLeast one material photo');
    } else {
      onTapSave();
    }
  }

  onTapSave() async {
    if (id != null) {
      await createTransactionAPi();
    }
    await devicePhotoApi();

    await materialPhotoAPi();

    for (int i = 0; i < barcodeData.length; i++) {
      String pickedIMageBse64='';
      if(imageFileList[i].path.isNotEmpty){
        File pickedImageFile = File(imageFileList[i].path);

        List<int> pickedImageBYte = await pickedImageFile.readAsBytes();
         pickedIMageBse64 = base64Encode(pickedImageBYte);
      }



      Uint8List? imageData;
      ByteData? qrImageData =
          await _generateQRCodeImage(barcodeData[i]['value']);
      if (qrImageData != null) {
        imageData = qrImageData.buffer.asUint8List();
        byteImageList[i] = imageData;

        update(["qr"]);
      }

      var data = {
        barcodeData[i]['name']: pickedIMageBse64,
        "${barcodeData[i]['name']}_barcode": barcodeData[i]['value'],
        "${barcodeData[i]['name']}_qr": base64Encode(imageData!),

      };

      if (barcodeData[i]['value'] != ''&& imageFileList[i].path.isNotEmpty) {
        statusList[i] = 'loader';
        await updateTransactionAPi(data);
        if (updateTransactionModel.message == 'Data Saved') {
          statusList[i] = 'verified';
          showToast('Data saved!');
        } else {
          statusList[i] = 'error';
          errorToast('Something went wrong!');
        }
      }

      update(['qr']);
    }
    update(['qr']);
  }

  Map<String, dynamic> map = {};
  String updateid = '';

  createTransactionAPi() async {
    try {
      loader.value = true;
      createTransactionModel =
          await CreateTransactionApi.createTransactionApi(id!, orgid,);
      updateid =
          createTransactionModel.transactionDetails?.outgoingPk.toString() ??
              '';

      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }

  UpdateTransactionModel updateTransactionModel = UpdateTransactionModel();

  updateTransactionAPi(body) async {
    try {
      loader.value = true;
      // statusList[initialIndex] = 'loader';

      updateTransactionModel =
          await UpdateTransactionApi.updateTransactionApi(updateid, body);

      // if (updateTransactionModel.message == 'Data Saved') {
      //   statusList[initialIndex] = 'verified';
      //   showToast('Data saved!');
      // } else {
      //   statusList[initialIndex] = 'error';
      //   errorToast('Something went wrong!');
      // }
      // update(['qr']);
      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }

  String savedImagePath = '';

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller!.scannedDataStream.listen(
      (scanData) async {
        update(["qr"]);
        result = scanData;
        debugPrint(isScanHandled.toString());
        String resultData = result?.code ?? "";

        barcodeData[initialIndex] = {
          'name': barcodeData[initialIndex]['name'],
          'value': resultData,
          'image': resultData,
        };
        barcodeDataImage[initialIndex] = resultData;
        debugPrint("----------------------------------------$resultData");
        update(["qr"]);
        isScanHandled = true;
        if (result != null) {
          debugPrint("$result");
          isBarcode = false;
          update(["qr"]);
          // Uint8List? imageData;
          // ByteData? qrImageData = await _generateQRCodeImage(resultData);
          // if (qrImageData != null) {
          //   imageData = qrImageData.buffer.asUint8List();
          //   byteImageList[initialIndex] = imageData;
          //
          //   update(["qr"]);
          // }
          //
          // map = {
          //   barcodeData[initialIndex]['name']: base64Encode(imageData!),
          //   "${barcodeData[initialIndex]['name']}_barcode:": resultData,
          // };

          // await updateTransactionAPi(map);
        } else {
          debugPrint("qr code give error");

          Get.snackbar('Error', 'QR not found!',
              colorText: Colors.white, backgroundColor: Colors.red);
        }
      },
    );
  }

  Future<File> base64ToFile(String base64String) async {
    Uint8List bytes = base64Decode(base64String);
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String filePath = '$tempPath/image.png';
    File imageFile = File(filePath);
    await imageFile.writeAsBytes(bytes);
    return imageFile;
  }

  Future<void> convertImageToFile() async {
    File imageFile = await base64ToFile(barcodeDataImage[0]);
    String imagePath = imageFile.path;
    debugPrint("======================: ${imagePath}");
  }

  Future<ByteData?> _generateQRCodeImage(String data) async {
    return await QrPainter(
      data: data,
      version: QrVersions.auto,
      color: Colors.black,
      emptyColor: Colors.white,
    ).toImageData(200);
  }

  Future<String> _saveImage(Uint8List imageData) async {
    final result = await ImageGallerySaver.saveImage(imageData);
    return result['filePath'];
  }

  imageDialog(context) async {
    await showModalBottomSheet(
        elevation: 10,
        barrierColor: ColorRes.black.withOpacity(0.4),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        backgroundColor: ColorRes.white,
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  Get.back();
                  final ImagePicker picker = ImagePicker();
                  final image =
                      await picker.pickImage(source: ImageSource.camera);

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);
                    update(['qr']);
                  }
                },
                child: ListTile(
                  leading: Icon(
                    Icons.camera,
                    color: ColorRes.appPrimary,
                  ),
                  title: Text(Strings.camera, style: blackSubTitle),
                ),
              ),
              Container(
                height: 0.5,
                width: Get.width,
                color: ColorRes.white,
              ),
              GestureDetector(

                onTap: () async {
                  Get.back();
                  final ImagePicker picker = ImagePicker();
                  final image =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);
                    update(['qr']);
                  }
                },
                child: ListTile(
                  leading: Icon(
                    Icons.photo_size_select_actual_outlined,
                    color: ColorRes.appPrimary,
                  ),
                  title: Text(Strings.gallery, style: blackSubTitle),
                ),
              ),
            ],
          );
        });
  }

  imageDialogForMaterialPhotos(context, int index) async {
    await showModalBottomSheet(
        elevation: 10,
        barrierColor: ColorRes.black.withOpacity(0.4),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        backgroundColor: ColorRes.white,
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  Get.back();
                  final ImagePicker picker = ImagePicker();
                  final image =
                      await picker.pickImage(source: ImageSource.camera);

                  if (image != null) {
                    materialPhotoList[index] = File(image.path);
                    if (materialPhotoList.length < 8) {
                      materialPhotoList.add(File(''));
                    }

                    update(['qr']);
                  }
                },
                child: ListTile(
                  leading: Icon(
                    Icons.camera,
                    color: ColorRes.appPrimary,
                  ),
                  title: Text(Strings.camera, style: blackSubTitle),
                ),
              ),
              Container(
                height: 0.5,
                width: Get.width,
                color: ColorRes.white,
              ),
              GestureDetector(
                onTap: () async {
                  Get.back();
                  final ImagePicker picker = ImagePicker();
                  final image =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (image != null) {
                    materialPhotoList[index] = File(image.path);
                    if (materialPhotoList.length < 8) {
                      materialPhotoList.add(File(''));
                    }

                    update(['qr']);
                  }
                },
                child: ListTile(
                  leading: Icon(
                    Icons.photo_size_select_actual_outlined,
                    color: ColorRes.appPrimary,
                  ),
                  title: Text(Strings.gallery, style: blackSubTitle),
                ),
              ),
            ],
          );
        });
  }

  imageDialogForDevicePhotos(context, int index) async {
    await showModalBottomSheet(
        elevation: 10,
        barrierColor: ColorRes.black.withOpacity(0.4),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        backgroundColor: ColorRes.white,
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  Get.back();
                  final ImagePicker picker = ImagePicker();
                  final image =
                      await picker.pickImage(source: ImageSource.camera);

                  if (image != null) {
                    if (index == 1) {
                      devicePhoto1 = File(image.path);
                    } else if (index == 2) {
                      devicePhoto2 = File(image.path);
                    } else {}
                    update(['qr']);
                  }
                },
                child: ListTile(
                  leading: Icon(
                    Icons.camera,
                    color: ColorRes.appPrimary,
                  ),
                  title: Text(Strings.camera, style: blackSubTitle),
                ),
              ),
              Container(
                height: 0.5,
                width: Get.width,
                color: ColorRes.white,
              ),
              GestureDetector(
                onTap: () async {
                  Get.back();
                  final ImagePicker picker = ImagePicker();
                  final image =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (image != null) {
                    if (index == 1) {
                      devicePhoto1 = File(image.path);
                    } else if (index == 2) {
                      devicePhoto2 = File(image.path);
                    } else {}
                    update(['qr']);
                  }
                },
                child: ListTile(
                  leading: Icon(
                    Icons.photo_size_select_actual_outlined,
                    color: ColorRes.appPrimary,
                  ),
                  title: Text(Strings.gallery, style: blackSubTitle),
                ),
              ),
            ],
          );
        });
  }
}
