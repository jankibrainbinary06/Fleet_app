import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_project/apis/create_transaction_api.dart';
import 'package:new_project/apis/update_transtion.dart';
import 'package:new_project/camera.dart';
import 'package:new_project/common/widgets/toasts.dart';
import 'package:new_project/global.dart';
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
  final String? orgIdMain;

  SearchResultController({this.id, this.orgIdMain});

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

  // CameraController? cameraController;
  bool isFlash = false;
  bool isMainFlash = false;
  bool homeFlash = false;
  RxBool isButtonEnabled = false.obs;

  String orgid = '';
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

  // late List<CameraDescription> cameras;

  @override
  Future<void> onInit() async {
    if (id != null && orgIdMain != null) {
      createTransactionAPi();
    }
    // cameras = await availableCameras();
    // cameraController = CameraController(cameras[0], ResolutionPreset.max);
    //
    // cameraController!.initialize();
    super.onInit();
  }

  enableButton() {
    print(statusList);
    int count = 0;
    for (int i = 0; i < statusList.length; i++) {
      if (statusList[i] == "verified") {
        count++;
      }
    }
    if (count == statusList.length) {
      isButtonEnabled.value = true;
    } else {
      isButtonEnabled.value = false;
    }
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
      isButtonEnabled.value = false;
      errorToast('Please select 2 device photos');
    } else if (materialPhotoList[0].path.isEmpty) {

      isButtonEnabled.value = false;
      errorToast('Please select atLeast one material photo');
    } else {
      isButtonEnabled.value = true;
      onTapSave();
    }
  }
  validate(){
    for(int i=0;i<statusList.length;i++){
      print(statusList[i]);
      if(statusList[i]!="verified"){
        isButtonEnabled.value = false;
        break;

      }else{
          print("suv");
        isButtonEnabled.value = true;
      }
    }
    if( isButtonEnabled.value == false){
      return;
    }
    else if (devicePhoto1.path.isEmpty || devicePhoto2.path.isEmpty) {
      isButtonEnabled.value = false;
      return;
      //errorToast('Please select 2 device photos');
    } else if (materialPhotoList[0].path.isEmpty) {

      isButtonEnabled.value = false;
      return;
      //errorToast('Please select atLeast one material photo');
    }else{
      isButtonEnabled.value = true;
    }
  }

  onTapSave() async {
    if (id != null) {
      // await createTransactionAPi();
    }
    //await devicePhotoApi();

   // await materialPhotoAPi();

    // for (int i = 0; i < barcodeData.length; i++) {
    //   String pickedIMageBse64 = '';
    //   if (imageFileList[i].path.isNotEmpty) {
    //     File pickedImageFile = File(imageFileList[i].path);
    //
    //     List<int> pickedImageBYte = await pickedImageFile.readAsBytes();
    //     pickedIMageBse64 = base64Encode(pickedImageBYte);
    //   }
    //
    //   Uint8List? imageData;
    //   ByteData? qrImageData =
    //       await _generateQRCodeImage(barcodeData[i]['value']);
    //   if (qrImageData != null) {
    //     imageData = qrImageData.buffer.asUint8List();
    //     byteImageList[i] = imageData;
    //
    //     update(["qr"]);
    //   }
    //
    //   var data = {
    //     barcodeData[i]['name']: pickedIMageBse64,
    //     "${barcodeData[i]['name']}_barcode": barcodeData[i]['value'],
    //     "${barcodeData[i]['name']}_qr": base64Encode(imageData!),
    //   };
    //
    //   if (barcodeData[i]['value'] != '' && imageFileList[i].path.isNotEmpty) {
    //     statusList[i] = 'loader';
    //     await updateTransactionAPi(data);
    //     if (updateTransactionModel.message == 'Data Saved') {
    //       statusList[i] = 'verified';
    //       showToast('Data saved!');
    //     } else {
    //       statusList[i] = 'error';
    //       errorToast('Something went wrong!');
    //     }
    //   }
    //
    //   update(['qr']);
    // }
    Get.back();
    update(['qr']);
  }

  Map<String, dynamic> map = {};
  String updateid = '';

  createTransactionAPi() async {
    try {
      loader.value = true;
      createTransactionModel = await CreateTransactionApi.createTransactionApi(
        id!,
        orgIdMain!,
      );
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

  void onQRViewCreated2(QRViewController controller) {
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

  void onQRViewCreatedL1(QRViewController controller) {
    this.controller = controller;
    // if( homeFlash == false  ){
    //
    // }
    // else {
    //   controller.toggleFlash();
    // }
    if (Global.isEnable == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {
        if (scanData != null) {
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

            if (imageFileList[initialIndex].path.isNotEmpty) {
              statusList[0] = 'loader';

              String pickedIMageBse64 = '';
              File pickedImageFile = File(imageFileList[initialIndex].path);

              List<int> pickedImageBYte = await pickedImageFile.readAsBytes();
              pickedIMageBse64 = base64Encode(pickedImageBYte);
              Uint8List? imageData;
              ByteData? qrImageData = await _generateQRCodeImage(resultData);
              if (qrImageData != null) {
                imageData = qrImageData.buffer.asUint8List();
                byteImageList[initialIndex] = imageData;

                update(["qr"]);
              }

              var data = {
                barcodeData[initialIndex]['name']: pickedIMageBse64,
                "${barcodeData[initialIndex]['name']}_barcode": resultData,
                "${barcodeData[initialIndex]['name']}_qr":
                    base64Encode(imageData!),
              };
              await updateTransactionAPi(data);
              if (updateTransactionModel.message == 'Data Saved') {
                statusList[0] = 'verified';
                showToast('Data saved!');
              } else {
                statusList[0] = 'error';
                errorToast('Something went wrong!');
              }
              validate();
              update(["qr"]);
            }

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
        } else {
          Get.snackbar('Error', "Barcode code found");
        }
      },
    );
  }

  void onQRViewCreatedL2(QRViewController controller) {
    this.controller = controller;
    // if( homeFlash == false  ){
    //
    // }
    // else {
    //   controller.toggleFlash();
    // }
    if (Global.isEnable == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {
        if (scanData != null) {
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

            if (imageFileList[initialIndex].path.isNotEmpty) {
              statusList[1] = 'loader';

              String pickedIMageBse64 = '';
              File pickedImageFile = File(imageFileList[initialIndex].path);

              List<int> pickedImageBYte = await pickedImageFile.readAsBytes();
              pickedIMageBse64 = base64Encode(pickedImageBYte);
              Uint8List? imageData;
              ByteData? qrImageData = await _generateQRCodeImage(resultData);
              if (qrImageData != null) {
                imageData = qrImageData.buffer.asUint8List();
                byteImageList[initialIndex] = imageData;

                update(["qr"]);
              }

              var data = {
                barcodeData[initialIndex]['name']: pickedIMageBse64,
                "${barcodeData[initialIndex]['name']}_barcode": resultData,
                "${barcodeData[initialIndex]['name']}_qr":
                    base64Encode(imageData!),
              };
              await updateTransactionAPi(data);
              if (updateTransactionModel.message == 'Data Saved') {
                statusList[1] = 'verified';
                showToast('Data saved!');
              } else {
                statusList[1] = 'error';
                errorToast('Something went wrong!');
              }
              validate();
              update(["qr"]);
            }

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
        } else {
          Get.snackbar('Error', "Barcode code found");
        }
      },
    );
  }

  void onQRViewCreatedL3(QRViewController controller) {
    this.controller = controller;
    // if( homeFlash == false  ){
    //
    // }
    // else {
    //   controller.toggleFlash();
    // }
    if (Global.isEnable == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {
        if (scanData != null) {
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

            if (imageFileList[initialIndex].path.isNotEmpty) {
              statusList[2] = 'loader';

              String pickedIMageBse64 = '';
              File pickedImageFile = File(imageFileList[initialIndex].path);

              List<int> pickedImageBYte = await pickedImageFile.readAsBytes();
              pickedIMageBse64 = base64Encode(pickedImageBYte);
              Uint8List? imageData;
              ByteData? qrImageData = await _generateQRCodeImage(resultData);
              if (qrImageData != null) {
                imageData = qrImageData.buffer.asUint8List();
                byteImageList[initialIndex] = imageData;

                update(["qr"]);
              }

              var data = {
                barcodeData[initialIndex]['name']: pickedIMageBse64,
                "${barcodeData[initialIndex]['name']}_barcode": resultData,
                "${barcodeData[initialIndex]['name']}_qr":
                    base64Encode(imageData!),
              };
              await updateTransactionAPi(data);
              if (updateTransactionModel.message == 'Data Saved') {
                statusList[2] = 'verified';
                showToast('Data saved!');
              } else {
                statusList[2] = 'error';
                errorToast('Something went wrong!');
              }
              validate();
              update(["qr"]);
            }

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
        } else {
          Get.snackbar('Error', "Barcode code found");
        }
      },
    );
  }

  void onQRViewCreatedL4(QRViewController controller) {
    this.controller = controller;
    // if( homeFlash == false  ){
    //
    // }
    // else {
    //   controller.toggleFlash();
    // }
    if (Global.isEnable == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {
        if (scanData != null) {
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

            if (imageFileList[initialIndex].path.isNotEmpty) {
              statusList[3] = 'loader';

              String pickedIMageBse64 = '';
              File pickedImageFile = File(imageFileList[initialIndex].path);

              List<int> pickedImageBYte = await pickedImageFile.readAsBytes();
              pickedIMageBse64 = base64Encode(pickedImageBYte);
              Uint8List? imageData;
              ByteData? qrImageData = await _generateQRCodeImage(resultData);
              if (qrImageData != null) {
                imageData = qrImageData.buffer.asUint8List();
                byteImageList[initialIndex] = imageData;

                update(["qr"]);
              }

              var data = {
                barcodeData[initialIndex]['name']: pickedIMageBse64,
                "${barcodeData[initialIndex]['name']}_barcode": resultData,
                "${barcodeData[initialIndex]['name']}_qr":
                    base64Encode(imageData!),
              };
              await updateTransactionAPi(data);
              if (updateTransactionModel.message == 'Data Saved') {
                statusList[3] = 'verified';
                showToast('Data saved!');
              } else {
                statusList[3] = 'error';
                errorToast('Something went wrong!');
              }
              validate();
              update(["qr"]);
            }

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
        } else {
          Get.snackbar('Error', "Barcode code found");
        }
      },
    );
  }

  void onQRViewCreatedL5(QRViewController controller) {
    this.controller = controller;
    // if( homeFlash == false  ){
    //
    // }
    // else {
    //   controller.toggleFlash();
    // }
    if (Global.isEnable == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {
        if (scanData != null) {
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

            if (imageFileList[initialIndex].path.isNotEmpty) {
              statusList[4] = 'loader';

              String pickedIMageBse64 = '';
              File pickedImageFile = File(imageFileList[initialIndex].path);

              List<int> pickedImageBYte = await pickedImageFile.readAsBytes();
              pickedIMageBse64 = base64Encode(pickedImageBYte);
              Uint8List? imageData;
              ByteData? qrImageData = await _generateQRCodeImage(resultData);
              if (qrImageData != null) {
                imageData = qrImageData.buffer.asUint8List();
                byteImageList[initialIndex] = imageData;

                update(["qr"]);
              }

              var data = {
                barcodeData[initialIndex]['name']: pickedIMageBse64,
                "${barcodeData[initialIndex]['name']}_barcode": resultData,
                "${barcodeData[initialIndex]['name']}_qr":
                    base64Encode(imageData!),
              };
              await updateTransactionAPi(data);
              if (updateTransactionModel.message == 'Data Saved') {
                statusList[4] = 'verified';
                showToast('Data saved!');
              } else {
                statusList[4] = 'error';
                errorToast('Something went wrong!');
              }
              validate();
              update(["qr"]);
            }

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
        } else {
          Get.snackbar('Error', "Barcode code found");
        }
      },
    );
  }

  void onQRViewCreatedR1(QRViewController controller) {
    this.controller = controller;
    // if( homeFlash == false  ){
    //
    // }
    // else {
    //   controller.toggleFlash();
    // }
    if (Global.isEnable == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {
        if (scanData != null) {
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

            if (imageFileList[initialIndex].path.isNotEmpty) {
              statusList[5] = 'loader';

              String pickedIMageBse64 = '';
              File pickedImageFile = File(imageFileList[initialIndex].path);

              List<int> pickedImageBYte = await pickedImageFile.readAsBytes();
              pickedIMageBse64 = base64Encode(pickedImageBYte);
              Uint8List? imageData;
              ByteData? qrImageData = await _generateQRCodeImage(resultData);
              if (qrImageData != null) {
                imageData = qrImageData.buffer.asUint8List();
                byteImageList[initialIndex] = imageData;

                update(["qr"]);
              }

              var data = {
                barcodeData[initialIndex]['name']: pickedIMageBse64,
                "${barcodeData[initialIndex]['name']}_barcode": resultData,
                "${barcodeData[initialIndex]['name']}_qr":
                    base64Encode(imageData!),
              };
              await updateTransactionAPi(data);
              if (updateTransactionModel.message == 'Data Saved') {
                statusList[5] = 'verified';
                showToast('Data saved!');
              } else {
                statusList[5] = 'error';
                errorToast('Something went wrong!');
              }
              validate();
              update(["qr"]);
            }

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
        } else {
          Get.snackbar('Error', "Barcode code found");
        }
      },
    );
  }

  void onQRViewCreatedR2(QRViewController controller) {
    this.controller = controller;
    // if( homeFlash == false  ){
    //
    // }
    // else {
    //   controller.toggleFlash();
    // }
    if (Global.isEnable == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {
        if (scanData != null) {
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

            if (imageFileList[initialIndex].path.isNotEmpty) {
              statusList[6] = 'loader';

              String pickedIMageBse64 = '';
              File pickedImageFile = File(imageFileList[initialIndex].path);

              List<int> pickedImageBYte = await pickedImageFile.readAsBytes();
              pickedIMageBse64 = base64Encode(pickedImageBYte);
              Uint8List? imageData;
              ByteData? qrImageData = await _generateQRCodeImage(resultData);
              if (qrImageData != null) {
                imageData = qrImageData.buffer.asUint8List();
                byteImageList[initialIndex] = imageData;

                update(["qr"]);
              }

              var data = {
                barcodeData[initialIndex]['name']: pickedIMageBse64,
                "${barcodeData[initialIndex]['name']}_barcode": resultData,
                "${barcodeData[initialIndex]['name']}_qr":
                    base64Encode(imageData!),
              };
              await updateTransactionAPi(data);
              if (updateTransactionModel.message == 'Data Saved') {
                statusList[6] = 'verified';
                showToast('Data saved!');
              } else {
                statusList[6] = 'error';
                errorToast('Something went wrong!');
              }
              validate();
              update(["qr"]);
            }

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
        } else {
          Get.snackbar('Error', "Barcode code found");
        }
      },
    );
  }

  void onQRViewCreatedR3(QRViewController controller) {
    this.controller = controller;
    // if( homeFlash == false  ){
    //
    // }
    // else {
    //   controller.toggleFlash();
    // }
    if (Global.isEnable == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {
        if (scanData != null) {
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

            if (imageFileList[initialIndex].path.isNotEmpty) {
              statusList[7] = 'loader';

              String pickedIMageBse64 = '';
              File pickedImageFile = File(imageFileList[initialIndex].path);

              List<int> pickedImageBYte = await pickedImageFile.readAsBytes();
              pickedIMageBse64 = base64Encode(pickedImageBYte);
              Uint8List? imageData;
              ByteData? qrImageData = await _generateQRCodeImage(resultData);
              if (qrImageData != null) {
                imageData = qrImageData.buffer.asUint8List();
                byteImageList[initialIndex] = imageData;

                update(["qr"]);
              }

              var data = {
                barcodeData[initialIndex]['name']: pickedIMageBse64,
                "${barcodeData[initialIndex]['name']}_barcode": resultData,
                "${barcodeData[initialIndex]['name']}_qr":
                    base64Encode(imageData!),
              };
              await updateTransactionAPi(data);
              if (updateTransactionModel.message == 'Data Saved') {
                statusList[7] = 'verified';
                showToast('Data saved!');
              } else {
                statusList[7] = 'error';
                errorToast('Something went wrong!');
              }
              validate();
              update(["qr"]);
            }

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
        } else {
          Get.snackbar('Error', "Barcode code found");
        }
      },
    );
  }

  void onQRViewCreatedR4(QRViewController controller) {
    this.controller = controller;
    // if( homeFlash == false  ){
    //
    // }
    // else {
    //   controller.toggleFlash();
    // }
    if (Global.isEnable == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {
        if (scanData != null) {
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

            if (imageFileList[initialIndex].path.isNotEmpty) {
              statusList[8] = 'loader';

              String pickedIMageBse64 = '';
              File pickedImageFile = File(imageFileList[initialIndex].path);

              List<int> pickedImageBYte = await pickedImageFile.readAsBytes();
              pickedIMageBse64 = base64Encode(pickedImageBYte);
              Uint8List? imageData;
              ByteData? qrImageData = await _generateQRCodeImage(resultData);
              if (qrImageData != null) {
                imageData = qrImageData.buffer.asUint8List();
                byteImageList[initialIndex] = imageData;

                update(["qr"]);
              }

              var data = {
                barcodeData[initialIndex]['name']: pickedIMageBse64,
                "${barcodeData[initialIndex]['name']}_barcode": resultData,
                "${barcodeData[initialIndex]['name']}_qr":
                    base64Encode(imageData!),
              };
              await updateTransactionAPi(data);
              if (updateTransactionModel.message == 'Data Saved') {
                statusList[8] = 'verified';
                showToast('Data saved!');
              } else {
                statusList[8] = 'error';
                errorToast('Something went wrong!');
              }
              validate();
              update(["qr"]);
            }

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
        } else {
          Get.snackbar('Error', "Barcode code found");
        }
      },
    );
  }

  void onQRViewCreatedR5(QRViewController controller) {
    this.controller = controller;
    // if( homeFlash == false  ){
    //
    // }
    // else {
    //   controller.toggleFlash();
    // }
    if (Global.isEnable == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {
        if (scanData != null) {
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

            if (imageFileList[initialIndex].path.isNotEmpty) {
              statusList[9] = 'loader';

              String pickedIMageBse64 = '';
              File pickedImageFile = File(imageFileList[initialIndex].path);

              List<int> pickedImageBYte = await pickedImageFile.readAsBytes();
              pickedIMageBse64 = base64Encode(pickedImageBYte);
              Uint8List? imageData;
              ByteData? qrImageData = await _generateQRCodeImage(resultData);
              if (qrImageData != null) {
                imageData = qrImageData.buffer.asUint8List();
                byteImageList[initialIndex] = imageData;

                update(["qr"]);
              }

              var data = {
                barcodeData[initialIndex]['name']: pickedIMageBse64,
                "${barcodeData[initialIndex]['name']}_barcode": resultData,
                "${barcodeData[initialIndex]['name']}_qr":
                    base64Encode(imageData!),
              };
              await updateTransactionAPi(data);
              if (updateTransactionModel.message == 'Data Saved') {
                statusList[9] = 'verified';
                showToast('Data saved!');
              } else {
                statusList[9] = 'error';
                errorToast('Something went wrong!');
              }
              validate();
              update(["qr"]);
            }

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
        } else {
          Get.snackbar('Error', "Barcode code found");
        }
      },
    );
  }

  void onQRViewCreatedF1(QRViewController controller) {
    this.controller = controller;
    // if( homeFlash == false  ){
    //
    // }
    // else {
    //   controller.toggleFlash();
    // }
    if (Global.isEnable == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {
        if (scanData != null) {
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

            if (imageFileList[initialIndex].path.isNotEmpty) {
              statusList[10] = 'loader';

              String pickedIMageBse64 = '';
              File pickedImageFile = File(imageFileList[initialIndex].path);

              List<int> pickedImageBYte = await pickedImageFile.readAsBytes();
              pickedIMageBse64 = base64Encode(pickedImageBYte);
              Uint8List? imageData;
              ByteData? qrImageData = await _generateQRCodeImage(resultData);
              if (qrImageData != null) {
                imageData = qrImageData.buffer.asUint8List();
                byteImageList[initialIndex] = imageData;

                update(["qr"]);
              }

              var data = {
                barcodeData[initialIndex]['name']: pickedIMageBse64,
                "${barcodeData[initialIndex]['name']}_barcode": resultData,
                "${barcodeData[initialIndex]['name']}_qr":
                    base64Encode(imageData!),
              };
              await updateTransactionAPi(data);
              if (updateTransactionModel.message == 'Data Saved') {
                statusList[10] = 'verified';
                showToast('Data saved!');
              } else {
                statusList[10] = 'error';
                errorToast('Something went wrong!');
              }
              validate();
              update(["qr"]);
            }

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
        } else {
          Get.snackbar('Error', "Barcode code found");
        }
      },
    );
  }

  void onQRViewCreatedF2(QRViewController controller) {
    this.controller = controller;
    // if( homeFlash == false  ){
    //
    // }
    // else {
    //   controller.toggleFlash();
    // }
    if (Global.isEnable == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {
        if (scanData != null) {
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

            if (imageFileList[initialIndex].path.isNotEmpty) {
              statusList[11] = 'loader';

              String pickedIMageBse64 = '';
              File pickedImageFile = File(imageFileList[initialIndex].path);

              List<int> pickedImageBYte = await pickedImageFile.readAsBytes();
              pickedIMageBse64 = base64Encode(pickedImageBYte);
              Uint8List? imageData;
              ByteData? qrImageData = await _generateQRCodeImage(resultData);
              if (qrImageData != null) {
                imageData = qrImageData.buffer.asUint8List();
                byteImageList[initialIndex] = imageData;

                update(["qr"]);
              }

              var data = {
                barcodeData[initialIndex]['name']: pickedIMageBse64,
                "${barcodeData[initialIndex]['name']}_barcode": resultData,
                "${barcodeData[initialIndex]['name']}_qr":
                    base64Encode(imageData!),
              };
              await updateTransactionAPi(data);
              if (updateTransactionModel.message == 'Data Saved') {
                statusList[11] = 'verified';
                showToast('Data saved!');
              } else {
                statusList[11] = 'error';
                errorToast('Something went wrong!');
              }
              validate();
              update(["qr"]);
            }

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
        } else {
          Get.snackbar('Error', "Barcode code found");
        }
      },
    );
  }

  void onQRViewCreatedB1(QRViewController controller) {
    this.controller = controller;
    // if( homeFlash == false  ){
    //
    // }
    // else {
    //   controller.toggleFlash();
    // }
    if (Global.isEnable == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {
        if (scanData != null) {
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

            if (imageFileList[initialIndex].path.isNotEmpty) {
              statusList[12] = 'loader';

              String pickedIMageBse64 = '';
              File pickedImageFile = File(imageFileList[initialIndex].path);

              List<int> pickedImageBYte = await pickedImageFile.readAsBytes();
              pickedIMageBse64 = base64Encode(pickedImageBYte);
              Uint8List? imageData;
              ByteData? qrImageData = await _generateQRCodeImage(resultData);
              if (qrImageData != null) {
                imageData = qrImageData.buffer.asUint8List();
                byteImageList[initialIndex] = imageData;

                update(["qr"]);
              }

              var data = {
                barcodeData[initialIndex]['name']: pickedIMageBse64,
                "${barcodeData[initialIndex]['name']}_barcode": resultData,
                "${barcodeData[initialIndex]['name']}_qr":
                    base64Encode(imageData!),
              };
              await updateTransactionAPi(data);
              if (updateTransactionModel.message == 'Data Saved') {
                statusList[12] = 'verified';
                showToast('Data saved!');
              } else {
                statusList[12] = 'error';
                errorToast('Something went wrong!');
              }
              validate();
              update(["qr"]);
            }

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
        } else {
          Get.snackbar('Error', "Barcode code found");
        }
      },
    );
  }

  void onQRViewCreatedB2(QRViewController controller) {
    this.controller = controller;
    // if( homeFlash == false  ){
    //
    // }
    // else {
    //   controller.toggleFlash();
    // }
    if (Global.isEnable == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {
        if (scanData != null) {
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

            if (imageFileList[initialIndex].path.isNotEmpty) {
              statusList[13] = 'loader';

              String pickedIMageBse64 = '';
              File pickedImageFile = File(imageFileList[initialIndex].path);

              List<int> pickedImageBYte = await pickedImageFile.readAsBytes();
              pickedIMageBse64 = base64Encode(pickedImageBYte);
              Uint8List? imageData;
              ByteData? qrImageData = await _generateQRCodeImage(resultData);
              if (qrImageData != null) {
                imageData = qrImageData.buffer.asUint8List();
                byteImageList[initialIndex] = imageData;

                update(["qr"]);
              }

              var data = {
                barcodeData[initialIndex]['name']: pickedIMageBse64,
                "${barcodeData[initialIndex]['name']}_barcode": resultData,
                "${barcodeData[initialIndex]['name']}_qr":
                    base64Encode(imageData!),
              };
              await updateTransactionAPi(data);
              if (updateTransactionModel.message == 'Data Saved') {
                statusList[13] = 'verified';
                showToast('Data saved!');
              } else {
                statusList[13] = 'error';
                errorToast('Something went wrong!');
              }
              validate();
              update(["qr"]);
            }

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
        } else {
          Get.snackbar('Error', "Barcode code found");
        }
      },
    );
  }

  qrView() {
    return QRView(
        cameraFacing: CameraFacing.back,
        key: qrKey,
        onQRViewCreated: initialIndex == 0
            ? onQRViewCreatedL1
            : initialIndex == 1
                ? onQRViewCreatedL2
                : initialIndex == 2
                    ? onQRViewCreatedL3
                    : initialIndex == 3
                        ? onQRViewCreatedL4
                        : initialIndex == 4
                            ? onQRViewCreatedL5
                            : initialIndex == 5
                                ? onQRViewCreatedR1
                                : initialIndex == 6
                                    ? onQRViewCreatedR2
                                    : initialIndex == 7
                                        ? onQRViewCreatedR3
                                        : initialIndex == 8
                                            ? onQRViewCreatedR4
                                            : initialIndex == 9
                                                ? onQRViewCreatedR5
                                                : initialIndex == 10
                                                    ? onQRViewCreatedF1
                                                    : initialIndex == 11
                                                        ? onQRViewCreatedF2
                                                        : initialIndex == 12
                                                            ? onQRViewCreatedB1
                                                            : onQRViewCreatedB2);
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

  imageDialogL1(context) async {
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
                  var image =await Get.to(CameraScreen());

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }
                      print("image <><><><><><><><><><><><><><><><><>");
                      //log(pickedIMageBse64);
                      print("image <><><><><><><><><><><><><><><><><>");
                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[0] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[0] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[0] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  enableButton();
                  Global().toggle();
                },
                child: ListTile(
                  leading: const Icon(
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

                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 25);

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }

                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[0] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[0] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[0] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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
  imageDialogL2(context) async {
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
                  var image =await Get.to(CameraScreen());

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }
                      print("image <><><><><><><><><><><><><><><><><>");
                      //log(pickedIMageBse64);
                      print("image <><><><><><><><><><><><><><><><><>");
                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[1] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[1] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[1] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  Global().toggle();
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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

                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 25);

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }

                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[1] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[1] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[1] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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
  imageDialogL3(context) async {
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
                  var image =await Get.to(CameraScreen());

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }
                      print("image <><><><><><><><><><><><><><><><><>");
                      //log(pickedIMageBse64);
                      print("image <><><><><><><><><><><><><><><><><>");
                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[2] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[2] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[2] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  Global().toggle();
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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

                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 25);

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }

                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[2] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[2] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[2] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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
  imageDialogL4(context) async {
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
                  var image =await Get.to(CameraScreen());
                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }
                      print("image <><><><><><><><><><><><><><><><><>");
                      //log(pickedIMageBse64);
                      print("image <><><><><><><><><><><><><><><><><>");
                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[3] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[3] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[3] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  Global().toggle();
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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

                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 25);

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }

                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[3] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[3] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[3] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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
  imageDialogL5(context) async {
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
                  var image =await Get.to(CameraScreen());

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }
                      print("image <><><><><><><><><><><><><><><><><>");
                     // log(pickedIMageBse64);
                      print("image <><><><><><><><><><><><><><><><><>");
                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[4] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[4] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[4] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  Global().toggle();
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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

                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 25);

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }

                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[4] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[4] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[4] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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
  imageDialogR1(context) async {
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
                  var image =await Get.to(CameraScreen());

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }
                      print("image <><><><><><><><><><><><><><><><><>");
                      log(pickedIMageBse64);
                      print("image <><><><><><><><><><><><><><><><><>");
                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[5] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[5] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[5] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();

                      update(["qr"]);
                    }
                  }
                  Global().toggle();
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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

                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 25);

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }

                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[5] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[5] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[5] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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
  imageDialogR2(context) async {
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
                  var image =await Get.to(CameraScreen());

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }
                      print("image <><><><><><><><><><><><><><><><><>");
                      log(pickedIMageBse64);
                      print("image <><><><><><><><><><><><><><><><><>");
                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[6] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[6] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[6] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  Global().toggle();
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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

                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 25);

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }

                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[6] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[6] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[6] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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
  imageDialogR3(context) async {
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
                  var image =await Get.to(CameraScreen());
                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }
                      print("image <><><><><><><><><><><><><><><><><>");
                      log(pickedIMageBse64);
                      print("image <><><><><><><><><><><><><><><><><>");
                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[7] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[7] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[7] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  Global().toggle();
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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

                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 25);

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }

                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[7] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[7] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[7] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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
  imageDialogR4(context) async {
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
                  var image =await Get.to(CameraScreen());

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }
                      print("image <><><><><><><><><><><><><><><><><>");
                      log(pickedIMageBse64);
                      print("image <><><><><><><><><><><><><><><><><>");
                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[8] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[8] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[8] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  Global().toggle();
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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

                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 25);

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }

                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[8] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[8] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[8] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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
  imageDialogR5(context) async {
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
                  var image =await Get.to(CameraScreen());

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }
                      print("image <><><><><><><><><><><><><><><><><>");
                      log(pickedIMageBse64);
                      print("image <><><><><><><><><><><><><><><><><>");
                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[9] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[9] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[9] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  Global().toggle();
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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

                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 25);

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }

                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[9] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[9] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[9] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();

                      update(["qr"]);
                    }
                  }
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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
  imageDialogF1(context) async {
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
                  var image =await Get.to(CameraScreen());
                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }
                      print("image <><><><><><><><><><><><><><><><><>");
                      log(pickedIMageBse64);
                      print("image <><><><><><><><><><><><><><><><><>");
                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[10] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[10] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[10] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  Global().toggle();
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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

                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 25);

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }

                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[10] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[10] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[10] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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
  imageDialogF2(context) async {
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
                  var image =await Get.to(CameraScreen());

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }
                      print("image <><><><><><><><><><><><><><><><><>");
                      log(pickedIMageBse64);
                      print("image <><><><><><><><><><><><><><><><><>");
                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[11] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[11] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[11] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  Global().toggle();
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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

                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 25);

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }

                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[11] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[11] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[11] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();

                      update(["qr"]);
                    }
                  }
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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
  imageDialogB1(context) async {
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
                  var image =await Get.to(CameraScreen());

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }
                      print("image <><><><><><><><><><><><><><><><><>");
                      log(pickedIMageBse64);
                      print("image <><><><><><><><><><><><><><><><><>");
                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[12] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[12] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[12] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  Global().toggle();
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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

                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 25);

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }

                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[12] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[12] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[12] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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
  imageDialogB2(context) async {
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
                  var image =await Get.to(CameraScreen());

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }
                      print("image <><><><><><><><><><><><><><><><><>");
                      log(pickedIMageBse64);
                      print("image <><><><><><><><><><><><><><><><><>");
                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[13] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[13] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[13] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  Global().toggle();
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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

                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 25);

                  if (image != null) {
                    imageFileList[initialIndex] = File(image.path);

                    update(['qr']);
                    if (barcodeData[initialIndex]['value'] != '') {
                      String pickedIMageBse64 = '';
                      if (imageFileList[initialIndex].path.isNotEmpty) {
                        File pickedImageFile =
                            File(imageFileList[initialIndex].path);

                        List<int> pickedImageBYte =
                            await pickedImageFile.readAsBytes();
                        pickedIMageBse64 = base64Encode(pickedImageBYte);
                      }

                      Uint8List? imageData;
                      ByteData? qrImageData = await _generateQRCodeImage(
                          barcodeData[initialIndex]['value']);
                      if (qrImageData != null) {
                        imageData = qrImageData.buffer.asUint8List();
                        byteImageList[initialIndex] = imageData;

                        update(["qr"]);
                      }

                      var data = {
                        barcodeData[initialIndex]['name']: pickedIMageBse64,
                        "${barcodeData[initialIndex]['name']}_barcode":
                            barcodeData[initialIndex]['value'],
                        "${barcodeData[initialIndex]['name']}_qr":
                            base64Encode(imageData!),
                      };

                      statusList[13] = 'loader';
                      await updateTransactionAPi(data);
                      if (updateTransactionModel.message == 'Data Saved') {
                        statusList[13] = 'verified';
                        showToast('Data saved!');
                      } else {
                        statusList[13] = 'error';
                        errorToast('Something went wrong!');
                      }
                      validate();
                      update(["qr"]);
                    }
                  }
                  enableButton();
                },
                child: ListTile(
                  leading: const Icon(
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

  chooseImageUpload(BuildContext context){
    if(initialIndex == 0){
      return imageDialogL1(context);
    }else if(initialIndex ==1){
      return imageDialogL2(context);
    }else if(initialIndex ==2){
      return imageDialogL3(context);
    }else if(initialIndex ==3){
      return imageDialogL4(context);
    }else if(initialIndex ==4){
      return imageDialogL5(context);
    }else if(initialIndex ==5){
      return imageDialogR1(context);
    }else if(initialIndex ==6){
      return imageDialogR2(context);
    }else if(initialIndex ==7){
      return imageDialogR3(context);
    }else if(initialIndex ==8){
      return imageDialogR4(context);
    }else if(initialIndex ==9){
      return imageDialogR5(context);
    }else if(initialIndex ==10){
      return imageDialogF1(context);
    }else if(initialIndex ==11){
      return imageDialogF2(context);
    }else if(initialIndex ==12){
      return imageDialogB1(context);
    }else{
      return imageDialogB2(context);
    }


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
                  var image =await Get.to(CameraScreen());

                  if (image != null) {
                    materialPhotoList[index] = File(image.path);
                    if (materialPhotoList.length < 8) {
                      materialPhotoList.add(File(''));
                    }
                    Uint8List imageBytes =
                        await materialPhotoList[index].readAsBytes();
                    String base64String = base64Encode(imageBytes);
                    Map map = {'mp${index + 1}': base64String};
                    await updateTransactionAPi(map);
                    update(['qr']);

                    update(['qr']);
                  }
                  Global().toggle();
                },
                child: ListTile(
                  leading: const Icon(
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
                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 25);
                  if (image != null) {
                    materialPhotoList[index] = File(image.path);
                    if (materialPhotoList.length < 8) {
                      materialPhotoList.add(File(''));
                    }
                    Uint8List imageBytes =
                        await materialPhotoList[index].readAsBytes();
                    String base64String = base64Encode(imageBytes);
                    Map map = {'mp${index + 1}': base64String};
                    await updateTransactionAPi(map);
                    update(['qr']);

                    update(['qr']);
                  }
                },
                child: ListTile(
                  leading: const Icon(
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
                  var image =await Get.to(CameraScreen());

                  if (image != null) {
                    if (index == 1) {
                      devicePhoto1 = File(image.path);

                      Uint8List imageBytes = await devicePhoto1.readAsBytes();
                      String base64String = base64Encode(imageBytes);
                      Map map = {'dp1': base64String};
                      await updateTransactionAPi(map);
                    } else if (index == 2) {
                      devicePhoto2 = File(image.path);
                      Uint8List imageBytes = await devicePhoto2.readAsBytes();
                      String base64String = base64Encode(imageBytes);
                      Map map = {'dp2': base64String};
                      await updateTransactionAPi(map);
                    } else {}
                    update(['qr']);
                  }
                  Global().toggle();
                },
                child: ListTile(
                  leading: const Icon(
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
                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 25);

                  if (image != null) {
                    if (index == 1) {
                      devicePhoto1 = File(image.path);

                      Uint8List imageBytes = await devicePhoto1.readAsBytes();
                      String base64String = base64Encode(imageBytes);
                      Map map = {'dp1': base64String};
                      await updateTransactionAPi(map);
                    } else if (index == 2) {
                      devicePhoto2 = File(image.path);
                      Uint8List imageBytes = await devicePhoto2.readAsBytes();
                      String base64String = base64Encode(imageBytes);
                      Map map = {'dp2': base64String};
                      await updateTransactionAPi(map);
                    } else {}
                    update(['qr']);
                  }
                },
                child: ListTile(
                  leading: const Icon(
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
