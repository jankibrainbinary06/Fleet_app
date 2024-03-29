import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_project/apis/create_transaction_api.dart';
import 'package:new_project/apis/get_transaction_api.dart';
import 'package:new_project/apis/mark_transaction_as_complete_api.dart';
import 'package:new_project/apis/marked_verified_api.dart';
import 'package:new_project/apis/update_transtion.dart';
import 'package:new_project/common/widgets/toasts.dart';
import 'package:new_project/models/create_transaction_model.dart';
import 'package:new_project/models/get_transaction_model.dart';
import 'package:new_project/models/marked_verified_model.dart';
import 'package:new_project/utils/color_res.dart';
import 'package:new_project/utils/string_res.dart';
import 'package:new_project/utils/text_styles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class IncomingQRController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isScanHandled = false;
  Barcode? result;
  String selectedData = '';
  bool isBarcode = false;
  RxBool loader = false.obs;
  int initialIndex = 0;
  String markedId = '';
  bool isFlash = false;
  bool homeFlash = false ;
  List<String> statusList = List.generate(14, (index) => '');
  List<File> imageFileList = List.generate(14, (index) => File(''));

  List<String> apiImageForQr =List.generate(14, (index) => '');


  List barcodeData = [
    {
      'name': 'l1',
      'image': '',
      "value": '',
      'apiQRImage':'',
    },
    {
      'name': 'l2',
      'image': '',
      "value": '',
      'apiQRImage':'',
    },
    {
      'name': 'l3',
      'image': '',
      "value": '',
      'apiQRImage':'',
    },
    {
      'name': 'l4',
      'image': '',
      "value": '',
      'apiQRImage':'',
    },
    {
      'name': 'l5',
      'image': '',
      "value": '',
      'apiQRImage':'',
    },
    {
      'name': 'r1',
      'image': '',
      "value": '',
      'apiQRImage':'',
    },
    {
      'name': 'r2',
      'image': '',
      "value": '',
      'apiQRImage':'',
    },
    {
      'name': 'r3',
      'image': '',
      "value": '',
      'apiQRImage':'',
    },
    {
      'name': 'r4',
      'image': '',
      "value": '',
      'apiQRImage':'',
    },
    {
      'name': 'r5',
      'image': '',
      "value": '',
      'apiQRImage':'',
    },
    {
      'name': 'f1',
      'image': '',
      "value": '',
      'apiQRImage':'',
    },
    {
      'name': 'f2',
      'image': '',
      "value": '',
      'apiQRImage':'',
    },
    {
      'name': 'b1',
      'image': '',
      "value": '',
      'apiQRImage':'',
    },
    {
      'name': 'b2',
      'image': '',
      "value": '',
      'apiQRImage':'',
    },
  ];

  List<String> barcodeDataImage = List.generate(14, (index) => '');
  List byteImageList = List.generate(14, (index) => []);
  CreateTransactionModel createTransactionModel = CreateTransactionModel();

  @override
  void onInit() {
  //  getTransactionApi(markedId);
    super.onInit();
  }

  String dp1 ='';
  String dp2 ='';
  bool isMainFlash = false;
  List materialPhoto =[];

  Map<String, dynamic> map = {};
  String updateid = '';
  MarkedVerifiedModel markedVerifiedModel = MarkedVerifiedModel();
  List<GetTransactionModel> getTransactionModel  = [];
  getTransactionApi(id) async {
    loader.value = true;
    getTransactionModel = await GetTransactionApi.getTransactionApi(id);
    barcodeData =[
      {
        'name': 'l1',
        'image': (getTransactionModel[0].l1 != null && getTransactionModel[0].l1 !='')?getTransactionModel[0].l1 ?? '':"",
        "value": "",
        'apiQRImage':(getTransactionModel[0].l1Qr != null && getTransactionModel[0].l1Qr !='')?getTransactionModel[0].l1Qr ?? '':"",
      },
      {
        'name': 'l2',
        'image': (getTransactionModel[0].l2 != null && getTransactionModel[0].l2 !='')?getTransactionModel[0].l2 ?? '':"",
        "value": "",
        'apiQRImage':(getTransactionModel[0].l2Qr != null && getTransactionModel[0].l2Qr !='')?getTransactionModel[0].l2Qr ?? '':"",

      },
      {
        'name': 'l3',
        'image': (getTransactionModel[0].l3 != null && getTransactionModel[0].l3 !='')?getTransactionModel[0].l3 :"",
        "value": "",
        'apiQRImage':(getTransactionModel[0].l3Qr != null && getTransactionModel[0].l3Qr !='')?getTransactionModel[0].l3Qr ?? '':"",

      },
      {
        'name': 'l4',
        'image': (getTransactionModel[0].l4 != null && getTransactionModel[0].l4 !='')?getTransactionModel[0].l4:"",
        "value": "",
        'apiQRImage':(getTransactionModel[0].l4Qr != null && getTransactionModel[0].l4Qr !='')?getTransactionModel[0].l4Qr ?? '':"",

      },
      {
        'name': 'l5',
        'image': (getTransactionModel[0].l5 != null && getTransactionModel[0].l5 !='')?getTransactionModel[0].l5:"",

        "value": "",
        'apiQRImage':(getTransactionModel[0].l5Qr != null && getTransactionModel[0].l5Qr !='')?getTransactionModel[0].l5Qr ?? '':"",

      },
      {
        'name': 'r1',
        'image': (getTransactionModel[0].r1 != null && getTransactionModel[0].r1 !='')?getTransactionModel[0].r1:"",
        "value": "",
        'apiQRImage':(getTransactionModel[0].r1Qr != null && getTransactionModel[0].r1Qr !='')?getTransactionModel[0].r1Qr ?? '':"",

      },
      {
        'name': 'r2',
        'image': (getTransactionModel[0].r2 != null && getTransactionModel[0].r2 !='')?getTransactionModel[0].r2:"",
        "value": "",
        'apiQRImage':(getTransactionModel[0].r2Qr != null && getTransactionModel[0].r2Qr !='')?getTransactionModel[0].r2Qr ?? '':"",

      },
      {
        'name': 'r3',
        'image': (getTransactionModel[0].r3 != null && getTransactionModel[0].r3 !='')?getTransactionModel[0].r3:"",
        "value": "",
        'apiQRImage':(getTransactionModel[0].r3Qr != null && getTransactionModel[0].r3Qr !='')?getTransactionModel[0].r3Qr ?? '':"",

      },
      {
        'name': 'r4',
        'image': (getTransactionModel[0].r4 != null && getTransactionModel[0].r4 !='')?getTransactionModel[0].r4:"",
        "value": "",
        'apiQRImage':(getTransactionModel[0].r4Qr != null && getTransactionModel[0].r4Qr !='')?getTransactionModel[0].r4Qr ?? '':"",

      },
      {
        'name': 'r5',
        'image': (getTransactionModel[0].r5 != null && getTransactionModel[0].r5 !='')?getTransactionModel[0].r5:"",
        "value": "",
        'apiQRImage':(getTransactionModel[0].r5Qr != null && getTransactionModel[0].r5Qr !='')?getTransactionModel[0].r5Qr ?? '':"",

      },
      {
        'name': 'f1',
        'image': (getTransactionModel[0].f1 != null && getTransactionModel[0].f1 !='')?getTransactionModel[0].f1:"",
        "value": "",
        'apiQRImage':(getTransactionModel[0].f1Qr != null && getTransactionModel[0].f1Qr !='')?getTransactionModel[0].f1Qr ?? '':"",

      },
      {
        'name': 'f2',
        'image': (getTransactionModel[0].f2 != null && getTransactionModel[0].f2 !='')?getTransactionModel[0].f2:"",
        "value": "",
        'apiQRImage':(getTransactionModel[0].f2Qr != null && getTransactionModel[0].f2Qr !='')?getTransactionModel[0].f2Qr ?? '':"",

      },
      {
        'name': 'b1',
        'image': (getTransactionModel[0].b1 != null && getTransactionModel[0].b1 !='')?getTransactionModel[0].b1:"",
        "value": "",
        'apiQRImage':(getTransactionModel[0].b1Qr != null && getTransactionModel[0].b1Qr !='')?getTransactionModel[0].b1Qr ?? '':"",

      },
      {
        'name': 'b2',
        'image': (getTransactionModel[0].b2 != null && getTransactionModel[0].b2 !='')?getTransactionModel[0]:"",
        "value": "",
        'apiQRImage':(getTransactionModel[0].b2Qr != null && getTransactionModel[0].b2Qr !='')?getTransactionModel[0].b2Qr ?? '':"",

      },
    ];
// dp1 =  (getTransactionModel[0].dp1 != null && getTransactionModel[0].dp1 !='')?getTransactionModel[0].dp1?.split(",")[1] ??'':'';
// dp2 =  (getTransactionModel[0].dp2 != null && getTransactionModel[0].dp2 !='')?getTransactionModel[0].dp2?.split(",")[1] ??'':'';
// materialPhoto= [];
// if(getTransactionModel[0].mp1 != null && getTransactionModel[0].mp1 !='')
//   {
//     materialPhoto.add(getTransactionModel[0].mp1?.split(",")[1] ??'');
//   }
// if(getTransactionModel[0].mp2 != null && getTransactionModel[0].mp2 !='')
//   {
//     materialPhoto.add(getTransactionModel[0].mp2?.split(",")[1] ??'');
//   }
// if(getTransactionModel[0].mp3 != null && getTransactionModel[0].mp3 !='')
//   {
//     materialPhoto.add(getTransactionModel[0].mp3?.split(",")[1] ??'');
//   }
// if(getTransactionModel[0].mp4 != null && getTransactionModel[0].mp4 !='')
//   {
//     materialPhoto.add(getTransactionModel[0].mp4?.split(",")[1] ??'');
//   }
// if(getTransactionModel[0].mp5 != null && getTransactionModel[0].mp5 !='')
//   {
//     materialPhoto.add(getTransactionModel[0].mp5?.split(",")[1] ??'');
//   }
// if(getTransactionModel[0].mp6 != null && getTransactionModel[0].mp6 !='')
//   {
//     materialPhoto.add(getTransactionModel[0].mp6?.split(",")[1] ??'');
//   }
// if(getTransactionModel[0].mp7 != null && getTransactionModel[0].mp7 !='')
//   {
//     materialPhoto.add(getTransactionModel[0].mp7?.split(",")[1] ??'');
//   }
// if(getTransactionModel[0].mp8 != null && getTransactionModel[0].mp8 !='')
//   {
//     materialPhoto.add(getTransactionModel[0].mp8?.split(",")[1] ??'');
//   }

    loader.value = false;
print(materialPhoto);
    update(['incomingQr']);
  }

  markedVerifiedAPi(body) async {
    try {
      loader.value = true;
      statusList[initialIndex] = 'loader';
      markedVerifiedModel =
          await MarkedVerifiedApi.markedVerifiedApi(markedId, body);
      loader.value = false;

      if (markedVerifiedModel.message == 'Barcode verified successfully') {
        statusList[initialIndex] = 'verified';
        showToast('Barcode verified successfully');
      } else {
        statusList[initialIndex] = 'error';
        barcodeDataImage[initialIndex] = '';
        barcodeData[initialIndex]['value'] = '';
        imageFileList[initialIndex] = File('');
        print(barcodeDataImage);
        errorToast('Barcode does not match');
      }
      update(['incomingQr']);
    } catch (e) {
      statusList[initialIndex] = '';
      barcodeDataImage[initialIndex] = '';
      barcodeData[initialIndex]['value'] = '';
      imageFileList[initialIndex] = File('');
      loader.value = false;
    }
  }

  String savedImagePath = '';

  void onQRViewCreated2(QRViewController controller) {
    this.controller = controller;
    controller!.scannedDataStream.listen(
      (scanData) async {
        update(["incomingQr"]);
        result = scanData;
        debugPrint(isScanHandled.toString());
        String resultData = result?.code ?? "";

        // barcodeData[initialIndex] = {
        //   'name': barcodeData[initialIndex]['name'],
        //   'value': resultData,
        //   'image': resultData,
        // };

        barcodeData[initialIndex]['value'] =resultData;
        barcodeDataImage[initialIndex] = resultData;
        debugPrint("----------------------------------------$resultData");
        update(["incomingQr"]);
        isScanHandled = true;
        if (result != null) {
          debugPrint("$result");
          isBarcode = false;
          update(["incomingQr"]);
          map = {
            'barcode': barcodeData[initialIndex]['name'],
            'barcode_value': resultData,
            "barcode_image": imageFileList[initialIndex].path
          };

          if(imageFileList[initialIndex].path !='') {
            await markedVerifiedAPi(map);
          }
        } else {
          debugPrint("qr code give error");

          Get.snackbar('Error', 'QR not found!',
              colorText: Colors.white, backgroundColor: Colors.red);
        }
      },
    );
  } void onQRViewCreated(QRViewController controller)  {
    this.controller = controller;

    if( homeFlash == true  ){
      controller.toggleFlash();

    }
    else {

    }
    controller!.scannedDataStream.listen(
      (scanData) async {
        update(["incomingQr"]);
        result = scanData;
        debugPrint(isScanHandled.toString());
        String resultData = result?.code ?? "";

        // barcodeData[initialIndex] = {
        //   'name': barcodeData[initialIndex]['name'],
        //   'value': resultData,
        //   'image': resultData,
        // };

        barcodeData[initialIndex]['value'] =resultData;
        barcodeDataImage[initialIndex] = resultData;
        debugPrint("----------------------------------------$resultData");
        update(["incomingQr"]);
        isScanHandled = true;
        if (result != null) {
          debugPrint("$result");
          isBarcode = false;
          update(["incomingQr"]);
          map = {
            'barcode': barcodeData[initialIndex]['name'],
            'barcode_value': resultData,
            "barcode_image": imageFileList[initialIndex].path
          };

          if(imageFileList[initialIndex].path !='') {
            await markedVerifiedAPi(map);
          }
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

  completeTransactionApi() async {
    loader.value = true;
   bool isComplete =  await CompleteTransactionApi.completeTransactionApi(markedId, );
   if(isComplete == true)
     {
       await Future.delayed(Duration(seconds: 3),(){
         Get.back();
       });
     }
    loader.value = false;
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
                      await picker.pickImage(source: ImageSource.camera,imageQuality: 30);

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    map = {
                      'barcode': barcodeData[initialIndex]['name'],
                      'barcode_value': barcodeDataImage[initialIndex],
                      "barcode_image": imageFileList[initialIndex].path
                    };

                    if(barcodeDataImage[initialIndex]!='' && imageFileList[initialIndex].path !='') {
                      await markedVerifiedAPi(map);
                    }
                    update(['incomingQr']);
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
                      await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);
                    map = {
                      'barcode': barcodeData[initialIndex]['name'],
                      'barcode_value': barcodeDataImage[initialIndex],
                      "barcode_image": imageFileList[initialIndex].path
                    };

                    if(barcodeDataImage[initialIndex]!='' && imageFileList[initialIndex].path !='') {
                      await markedVerifiedAPi(map);
                    }
                    update(['incomingQr']);
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
