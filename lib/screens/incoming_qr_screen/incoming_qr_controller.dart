import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
  final GlobalKey qrKey1 = GlobalKey(debugLabel: 'QR');
  String markedId = '';

  IncomingQRController({required this.markedId});

  QRViewController? controller;
  bool isScanHandled = false;
  Barcode? result;
  String selectedData = '';
  bool isBarcode = false;
  RxBool loader = false.obs;
  int initialIndex = 0;
  bool isFlash = false;
  bool homeFlash = false;
  List<String> statusList = List.generate(14, (index) => '');
  List<File> imageFileList = List.generate(14, (index) => File(''));

  List<String> apiImageForQr = List.generate(14, (index) => '');
  RxBool isButtonEnabled = false.obs;





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
  List barcodeData = [
    {
      'name': 'l1',
      'image': '',
      "value": '',
      'apiQRImage': '',
    },
    {
      'name': 'l2',
      'image': '',
      "value": '',
      'apiQRImage': '',
    },
    {
      'name': 'l3',
      'image': '',
      "value": '',
      'apiQRImage': '',
    },
    {
      'name': 'l4',
      'image': '',
      "value": '',
      'apiQRImage': '',
    },
    {
      'name': 'l5',
      'image': '',
      "value": '',
      'apiQRImage': '',
    },
    {
      'name': 'r1',
      'image': '',
      "value": '',
      'apiQRImage': '',
    },
    {
      'name': 'r2',
      'image': '',
      "value": '',
      'apiQRImage': '',
    },
    {
      'name': 'r3',
      'image': '',
      "value": '',
      'apiQRImage': '',
    },
    {
      'name': 'r4',
      'image': '',
      "value": '',
      'apiQRImage': '',
    },
    {
      'name': 'r5',
      'image': '',
      "value": '',
      'apiQRImage': '',
    },
    {
      'name': 'f1',
      'image': '',
      "value": '',
      'apiQRImage': '',
    },
    {
      'name': 'f2',
      'image': '',
      "value": '',
      'apiQRImage': '',
    },
    {
      'name': 'b1',
      'image': '',
      "value": '',
      'apiQRImage': '',
    },
    {
      'name': 'b2',
      'image': '',
      "value": '',
      'apiQRImage': '',
    },
  ];

  List<String> barcodeDataImage = List.generate(14, (index) => '');
  List byteImageList = List.generate(14, (index) => []);
  CreateTransactionModel createTransactionModel = CreateTransactionModel();

  @override
  void onInit() {
      getTransactionApi(markedId);
    super.onInit();
  }

  String dp1 = '';
  String dp2 = '';
  bool isMainFlash = false;
  List materialPhoto = [];

  Map<String, dynamic> map = {};
  String updateid = '';
  MarkedVerifiedModel markedVerifiedModel = MarkedVerifiedModel();
  List<GetTransactionModel> getTransactionModel = [];
  List<Uint8List> compressedImages = [];
  getTransactionApi(id) async {
    loader.value = true;
    getTransactionModel = [];
    barcodeData = [
      {
        'name': 'l1',
        'image': '',
        "value": '',
        'apiQRImage': '',
      },
      {
        'name': 'l2',
        'image': '',
        "value": '',
        'apiQRImage': '',
      },
      {
        'name': 'l3',
        'image': '',
        "value": '',
        'apiQRImage': '',
      },
      {
        'name': 'l4',
        'image': '',
        "value": '',
        'apiQRImage': '',
      },
      {
        'name': 'l5',
        'image': '',
        "value": '',
        'apiQRImage': '',
      },
      {
        'name': 'r1',
        'image': '',
        "value": '',
        'apiQRImage': '',
      },
      {
        'name': 'r2',
        'image': '',
        "value": '',
        'apiQRImage': '',
      },
      {
        'name': 'r3',
        'image': '',
        "value": '',
        'apiQRImage': '',
      },
      {
        'name': 'r4',
        'image': '',
        "value": '',
        'apiQRImage': '',
      },
      {
        'name': 'r5',
        'image': '',
        "value": '',
        'apiQRImage': '',
      },
      {
        'name': 'f1',
        'image': '',
        "value": '',
        'apiQRImage': '',
      },
      {
        'name': 'f2',
        'image': '',
        "value": '',
        'apiQRImage': '',
      },
      {
        'name': 'b1',
        'image': '',
        "value": '',
        'apiQRImage': '',
      },
      {
        'name': 'b2',
        'image': '',
        "value": '',
        'apiQRImage': '',
      },
    ];
    getTransactionModel = await GetTransactionApi.getTransactionApi(id);

    barcodeData = [
      {
        'name': 'l1',
        'image': (getTransactionModel[0].l1 != null &&
                getTransactionModel[0].l1 != '')
            ? getTransactionModel[0].l1 ?? ''
            : "",
        "value": "",
        'apiQRImage': (getTransactionModel[0].l1Qr != null &&
                getTransactionModel[0].l1Qr != '')
            ? getTransactionModel[0].l1Qr ?? ''
            : "",
      },
      {
        'name': 'l2',
        'image': (getTransactionModel[0].l2 != null &&
                getTransactionModel[0].l2 != '')
            ? getTransactionModel[0].l2 ?? ''
            : "",
        "value": "",
        'apiQRImage': (getTransactionModel[0].l2Qr != null &&
                getTransactionModel[0].l2Qr != '')
            ? getTransactionModel[0].l2Qr ?? ''
            : "",
      },
      {
        'name': 'l3',
        'image': (getTransactionModel[0].l3 != null &&
                getTransactionModel[0].l3 != '')
            ? getTransactionModel[0].l3
            : "",
        "value": "",
        'apiQRImage': (getTransactionModel[0].l3Qr != null &&
                getTransactionModel[0].l3Qr != '')
            ? getTransactionModel[0].l3Qr ?? ''
            : "",
      },
      {
        'name': 'l4',
        'image': (getTransactionModel[0].l4 != null &&
                getTransactionModel[0].l4 != '')
            ? getTransactionModel[0].l4
            : "",
        "value": "",
        'apiQRImage': (getTransactionModel[0].l4Qr != null &&
                getTransactionModel[0].l4Qr != '')
            ? getTransactionModel[0].l4Qr ?? ''
            : "",
      },
      {
        'name': 'l5',
        'image': (getTransactionModel[0].l5 != null &&
                getTransactionModel[0].l5 != '')
            ? getTransactionModel[0].l5
            : "",
        "value": "",
        'apiQRImage': (getTransactionModel[0].l5Qr != null &&
                getTransactionModel[0].l5Qr != '')
            ? getTransactionModel[0].l5Qr ?? ''
            : "",
      },
      {
        'name': 'r1',
        'image': (getTransactionModel[0].r1 != null &&
                getTransactionModel[0].r1 != '')
            ? getTransactionModel[0].r1
            : "",
        "value": "",
        'apiQRImage': (getTransactionModel[0].r1Qr != null &&
                getTransactionModel[0].r1Qr != '')
            ? getTransactionModel[0].r1Qr ?? ''
            : "",
      },
      {
        'name': 'r2',
        'image': (getTransactionModel[0].r2 != null &&
                getTransactionModel[0].r2 != '')
            ? getTransactionModel[0].r2
            : "",
        "value": "",
        'apiQRImage': (getTransactionModel[0].r2Qr != null &&
                getTransactionModel[0].r2Qr != '')
            ? getTransactionModel[0].r2Qr ?? ''
            : "",
      },
      {
        'name': 'r3',
        'image': (getTransactionModel[0].r3 != null &&
                getTransactionModel[0].r3 != '')
            ? getTransactionModel[0].r3
            : "",
        "value": "",
        'apiQRImage': (getTransactionModel[0].r3Qr != null &&
                getTransactionModel[0].r3Qr != '')
            ? getTransactionModel[0].r3Qr ?? ''
            : "",
      },
      {
        'name': 'r4',
        'image': (getTransactionModel[0].r4 != null &&
                getTransactionModel[0].r4 != '')
            ? getTransactionModel[0].r4
            : "",
        "value": "",
        'apiQRImage': (getTransactionModel[0].r4Qr != null &&
                getTransactionModel[0].r4Qr != '')
            ? getTransactionModel[0].r4Qr ?? ''
            : "",
      },
      {
        'name': 'r5',
        'image': (getTransactionModel[0].r5 != null &&
                getTransactionModel[0].r5 != '')
            ? getTransactionModel[0].r5
            : "",
        "value": "",
        'apiQRImage': (getTransactionModel[0].r5Qr != null &&
                getTransactionModel[0].r5Qr != '')
            ? getTransactionModel[0].r5Qr ?? ''
            : "",
      },
      {
        'name': 'f1',
        'image': (getTransactionModel[0].f1 != null &&
                getTransactionModel[0].f1 != '')
            ? getTransactionModel[0].f1
            : "",
        "value": "",
        'apiQRImage': (getTransactionModel[0].f1Qr != null &&
                getTransactionModel[0].f1Qr != '')
            ? getTransactionModel[0].f1Qr ?? ''
            : "",
      },
      {
        'name': 'f2',
        'image': (getTransactionModel[0].f2 != null &&
                getTransactionModel[0].f2 != '')
            ? getTransactionModel[0].f2
            : "",
        "value": "",
        'apiQRImage': (getTransactionModel[0].f2Qr != null &&
                getTransactionModel[0].f2Qr != '')
            ? getTransactionModel[0].f2Qr ?? ''
            : "",
      },
      {
        'name': 'b1',
        'image': (getTransactionModel[0].b1 != null &&
                getTransactionModel[0].b1 != '')
            ? getTransactionModel[0].b1
            : "",
        "value": "",
        'apiQRImage': (getTransactionModel[0].b1Qr != null &&
                getTransactionModel[0].b1Qr != '')
            ? getTransactionModel[0].b1Qr ?? ''
            : "",
      },
      {
        'name': 'b2',
        'image': (getTransactionModel[0].b2 != null &&
                getTransactionModel[0].b2 != '')
            ? getTransactionModel[0].b2
            : "",
        "value": "",
        'apiQRImage': (getTransactionModel[0].b2Qr != null &&
                getTransactionModel[0].b2Qr != '')
            ? getTransactionModel[0].b2Qr ?? ''
            : "",
      },
    ];

   // await compressImages();
    dp1 =
        (getTransactionModel[0].dp1 != null && getTransactionModel[0].dp1 != '')
            ? getTransactionModel[0].dp1?.split(",")[1] ?? ''
            : '';
    dp2 =
        (getTransactionModel[0].dp2 != null && getTransactionModel[0].dp2 != '')
            ? getTransactionModel[0].dp2?.split(",")[1] ?? ''
            : '';
    materialPhoto = [];
    if (getTransactionModel[0].mp1 != null &&
        getTransactionModel[0].mp1 != '') {
      materialPhoto.add(getTransactionModel[0].mp1?.split(",")[1] ?? '');
    }
    if (getTransactionModel[0].mp2 != null &&
        getTransactionModel[0].mp2 != '') {
      materialPhoto.add(getTransactionModel[0].mp2?.split(",")[1] ?? '');
    }
    if (getTransactionModel[0].mp3 != null &&
        getTransactionModel[0].mp3 != '') {
      materialPhoto.add(getTransactionModel[0].mp3?.split(",")[1] ?? '');
    }
    if (getTransactionModel[0].mp4 != null &&
        getTransactionModel[0].mp4 != '') {
      materialPhoto.add(getTransactionModel[0].mp4?.split(",")[1] ?? '');
    }
    if (getTransactionModel[0].mp5 != null &&
        getTransactionModel[0].mp5 != '') {
      materialPhoto.add(getTransactionModel[0].mp5?.split(",")[1] ?? '');
    }
    if (getTransactionModel[0].mp6 != null &&
        getTransactionModel[0].mp6 != '') {
      materialPhoto.add(getTransactionModel[0].mp6?.split(",")[1] ?? '');
    }
    if (getTransactionModel[0].mp7 != null &&
        getTransactionModel[0].mp7 != '') {
      materialPhoto.add(getTransactionModel[0].mp7?.split(",")[1] ?? '');
    }
    if (getTransactionModel[0].mp8 != null &&
        getTransactionModel[0].mp8 != '') {
      materialPhoto.add(getTransactionModel[0].mp8?.split(",")[1] ?? '');
    }

    //await Future.delayed(Duration(seconds: 30), () {
      loader.value = false;
   // });

    update(['incomingQr']);
  }

  Future<void> compressImages() async {
    // for (var base64String in barcodeData) {
    //   Uint8List bytes = base64Decode(base64String["image"]);
    //   List<int> compressedBytes = await FlutterImageCompress.compressWithList(
    //     bytes,
    //     minWidth: 800,
    //     minHeight: 600,
    //     quality: 80,
    //   );
    //   compressedImages.add(Uint8List.fromList(compressedBytes));
    // }
  }

  qrView() {

    return QRView(
        cameraFacing: CameraFacing.back,
        key: qrKey1,
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

  markedVerifiedAPi(body,index) async {
    try {
      loader.value = true;
      statusList[index] = 'loader';
      markedVerifiedModel =
          await MarkedVerifiedApi.markedVerifiedApi(markedId, body);
      loader.value = false;

      if (markedVerifiedModel.message == 'Barcode verified successfully') {
        statusList[index] = 'verified';
        showToast('Barcode verified successfully');
      } else {
        statusList[index] = 'error';
        barcodeDataImage[index] = '';

        imageFileList[index] = File('');

        errorToast('Barcode does not match');
      }

      enableButton();
      update(['incomingQr']);
    } catch (e) {
      statusList[index] = '';
      barcodeDataImage[index] = '';
      imageFileList[index] = File('');
      loader.value = false;
    }
  }

  String savedImagePath = '';

  void onQRViewCreated2(QRViewController controller) {
    this.controller = controller;
    controller!.scannedDataStream.listen(
      (scanData) async {

        result = scanData;
        String resultData = result?.code ?? "";

        // barcodeData[initialIndex] = {
        //   'name': barcodeData[initialIndex]['name'],
        //   'value': resultData,
        //   'image': resultData,
        // };

      //  barcodeData[initialIndex]['value'] = resultData;
        barcodeDataImage[initialIndex] = resultData;

        isScanHandled = true;
        if (result != null) {

          isBarcode = false;

          map = {
            'barcode': barcodeData[initialIndex]['name'],
            'barcode_value': resultData,
            "barcode_image": imageFileList[initialIndex].path
          };

          if (imageFileList[initialIndex].path != '') {
            await markedVerifiedAPi(map,initialIndex);
          }
        } else {


          Get.snackbar('Error', 'QR not found!',
              colorText: Colors.white, backgroundColor: Colors.red);
        }
        update(["incomingQr"]);
      },
    );
  }

  void onQRViewCreatedL1(QRViewController controller) {
    this.controller = controller;

    if (homeFlash == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {
        //update(["incomingQr"]);
        result = scanData;
        String resultData = result?.code ?? "";

        // barcodeData[initialIndex] = {
        //   'name': barcodeData[initialIndex]['name'],
        //   'value': resultData,
        //   'image': resultData,
        // };

        //barcodeData[0]['value'] = resultData;
        barcodeDataImage[0] = resultData;

        isScanHandled = true;
        if (result != null) {
          isBarcode = false;
          controller.dispose();
          map = {
            'barcode': barcodeData[0]['name'],
            'barcode_value': resultData,
            "barcode_image": imageFileList[0].path
          };

          if (imageFileList[0].path != '') {
            await markedVerifiedAPi(map,0);
          }
        } else {

          Get.snackbar('Error', 'QR not found!',
              colorText: Colors.white, backgroundColor: Colors.red);
        }

        update(["incomingQr"]);
      },
    );
  }
  void onQRViewCreatedL2(QRViewController controller) {
    this.controller = controller;

    if (homeFlash == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {

        result = scanData;

        String resultData = result?.code ?? "";

        // barcodeData[initialIndex] = {
        //   'name': barcodeData[initialIndex]['name'],
        //   'value': resultData,
        //   'image': resultData,
        // };

        //barcodeData[1]['value'] = resultData;
        barcodeDataImage[1] = resultData;

        isScanHandled = true;
        if (result != null) {
          isBarcode = false;

          map = {
            'barcode': barcodeData[1]['name'],
            'barcode_value': resultData,
            "barcode_image": imageFileList[1].path
          };

          if (imageFileList[1].path != '') {
            await markedVerifiedAPi(map,1);
          }
        } else {

          Get.snackbar('Error', 'QR not found!',
              colorText: Colors.white, backgroundColor: Colors.red);
        }
        update(["incomingQr"]);
      },
    );
  }
  void onQRViewCreatedL3(QRViewController controller) {
    this.controller = controller;

    if (homeFlash == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {

        result = scanData;

        String resultData = result?.code ?? "";

        // barcodeData[initialIndex] = {
        //   'name': barcodeData[initialIndex]['name'],
        //   'value': resultData,
        //   'image': resultData,
        // };

        //barcodeData[2]['value'] = resultData;
        barcodeDataImage[2] = resultData;

        isScanHandled = true;
        if (result != null) {
          isBarcode = false;

          map = {
            'barcode': barcodeData[2]['name'],
            'barcode_value': resultData,
            "barcode_image": imageFileList[2].path
          };

          if (imageFileList[2].path != '') {
            await markedVerifiedAPi(map,2);
          }
        } else {

          Get.snackbar('Error', 'QR not found!',
              colorText: Colors.white, backgroundColor: Colors.red);
        }
        update(["incomingQr"]);
      },
    );
  }

  void onQRViewCreatedL4(QRViewController controller) {
    this.controller = controller;

    if (homeFlash == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {

        result = scanData;

        String resultData = result?.code ?? "";

        // barcodeData[initialIndex] = {
        //   'name': barcodeData[initialIndex]['name'],
        //   'value': resultData,
        //   'image': resultData,
        // };

        //barcodeData[3]['value'] = resultData;
        barcodeDataImage[3] = resultData;

        isScanHandled = true;
        if (result != null) {
          isBarcode = false;

          map = {
            'barcode': barcodeData[3]['name'],
            'barcode_value': resultData,
            "barcode_image": imageFileList[3].path
          };

          if (imageFileList[3].path != '') {
            await markedVerifiedAPi(map,3);
          }
        } else {

          Get.snackbar('Error', 'QR not found!',
              colorText: Colors.white, backgroundColor: Colors.red);
        }
        update(["incomingQr"]);
      },
    );
  }
  void onQRViewCreatedL5(QRViewController controller) {
    this.controller = controller;

    if (homeFlash == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {

        result = scanData;

        String resultData = result?.code ?? "";

        // barcodeData[initialIndex] = {
        //   'name': barcodeData[initialIndex]['name'],
        //   'value': resultData,
        //   'image': resultData,
        // };

        //barcodeData[4]['value'] = resultData;
        barcodeDataImage[4] = resultData;

        isScanHandled = true;
        if (result != null) {
          isBarcode = false;

          map = {
            'barcode': barcodeData[4]['name'],
            'barcode_value': resultData,
            "barcode_image": imageFileList[4].path
          };

          if (imageFileList[4].path != '') {
            await markedVerifiedAPi(map,4);
          }
        } else {

          Get.snackbar('Error', 'QR not found!',
              colorText: Colors.white, backgroundColor: Colors.red);
        }
        update(["incomingQr"]);
      },
    );
  }
  void onQRViewCreatedR1(QRViewController controller) {
    this.controller = controller;

    if (homeFlash == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
      (scanData) async {

        result = scanData;

        String resultData = result?.code ?? "";

        // barcodeData[initialIndex] = {
        //   'name': barcodeData[initialIndex]['name'],
        //   'value': resultData,
        //   'image': resultData,
        // };

        //barcodeData[5]['value'] = resultData;
        barcodeDataImage[5] = resultData;

        isScanHandled = true;
        if (result != null) {
          isBarcode = false;

          map = {
            'barcode': barcodeData[5]['name'],
            'barcode_value': resultData,
            "barcode_image": imageFileList[5].path
          };

          if (imageFileList[5].path != '') {
            await markedVerifiedAPi(map,5);
          }
        } else {

          Get.snackbar('Error', 'QR not found!',
              colorText: Colors.white, backgroundColor: Colors.red);
        }
        update(["incomingQr"]);
      },
    );
  }
  void onQRViewCreatedR2(QRViewController controller) {
    this.controller = controller;

    if (homeFlash == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
          (scanData) async {

        result = scanData;

        String resultData = result?.code ?? "";

        // barcodeData[initialIndex] = {
        //   'name': barcodeData[initialIndex]['name'],
        //   'value': resultData,
        //   'image': resultData,
        // };

        //barcodeData[6]['value'] = resultData;
        barcodeDataImage[6] = resultData;

        isScanHandled = true;
        if (result != null) {
          isBarcode = false;

          map = {
            'barcode': barcodeData[6]['name'],
            'barcode_value': resultData,
            "barcode_image": imageFileList[6].path
          };

          if (imageFileList[6].path != '') {
            await markedVerifiedAPi(map,6);
          }
        } else {

          Get.snackbar('Error', 'QR not found!',
              colorText: Colors.white, backgroundColor: Colors.red);
        }
        update(["incomingQr"]);
      },
    );
  }
  void onQRViewCreatedR3(QRViewController controller) {
    this.controller = controller;

    if (homeFlash == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
          (scanData) async {

        result = scanData;

        String resultData = result?.code ?? "";

        // barcodeData[initialIndex] = {
        //   'name': barcodeData[initialIndex]['name'],
        //   'value': resultData,
        //   'image': resultData,
        // };

        //barcodeData[7]['value'] = resultData;
        barcodeDataImage[7] = resultData;

        isScanHandled = true;
        if (result != null) {
          isBarcode = false;

          map = {
            'barcode': barcodeData[7]['name'],
            'barcode_value': resultData,
            "barcode_image": imageFileList[7].path
          };

          if (imageFileList[7].path != '') {
            await markedVerifiedAPi(map,7);
          }
        } else {

          Get.snackbar('Error', 'QR not found!',
              colorText: Colors.white, backgroundColor: Colors.red);
        }
        update(["incomingQr"]);
      },
    );
  }
  void onQRViewCreatedR4(QRViewController controller) {
    this.controller = controller;

    if (homeFlash == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
          (scanData) async {

        result = scanData;
        String resultData = result?.code ?? "";

        // barcodeData[initialIndex] = {
        //   'name': barcodeData[initialIndex]['name'],
        //   'value': resultData,
        //   'image': resultData,
        // };

        //barcodeData[8]['value'] = resultData;

        isScanHandled = true;
        if (result != null) {
          isBarcode = false;

          map = {
            'barcode': barcodeData[8]['name'],
            'barcode_value': resultData,
            "barcode_image": imageFileList[8].path
          };

          if (imageFileList[8].path != '') {
            await markedVerifiedAPi(map,8);
          }
        } else {

          Get.snackbar('Error', 'QR not found!',
              colorText: Colors.white, backgroundColor: Colors.red);
        }
        update(["incomingQr"]);
      },
    );
  }
  void onQRViewCreatedR5(QRViewController controller) {
    this.controller = controller;

    if (homeFlash == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
          (scanData) async {

        result = scanData;
        String resultData = result?.code ?? "";

        // barcodeData[initialIndex] = {
        //   'name': barcodeData[initialIndex]['name'],
        //   'value': resultData,
        //   'image': resultData,
        // };

        //barcodeData[9]['value'] = resultData;
        barcodeDataImage[9] = resultData;

        isScanHandled = true;
        if (result != null) {
          isBarcode = false;

          map = {
            'barcode': barcodeData[9]['name'],
            'barcode_value': resultData,
            "barcode_image": imageFileList[9].path
          };

          if (imageFileList[9].path != '') {
            await markedVerifiedAPi(map,9);
          }
        } else {

          Get.snackbar('Error', 'QR not found!',
              colorText: Colors.white, backgroundColor: Colors.red);
        }
        update(["incomingQr"]);
      },
    );
  }
  void onQRViewCreatedF1(QRViewController controller) {
    this.controller = controller;

    if (homeFlash == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
          (scanData) async {
        update(["incomingQr"]);        result = scanData;
        String resultData = result?.code ?? "";

        // barcodeData[initialIndex] = {
        //   'name': barcodeData[initialIndex]['name'],
        //   'value': resultData,
        //   'image': resultData,
        // };

       // barcodeData[10]['value'] = resultData;
        barcodeDataImage[10] = resultData;

        isScanHandled = true;
        if (result != null) {
          isBarcode = false;

          map = {
            'barcode': barcodeData[10]['name'],
            'barcode_value': resultData,
            "barcode_image": imageFileList[10].path
          };

          if (imageFileList[10].path != '') {
            await markedVerifiedAPi(map,10);
          }
        } else {

          Get.snackbar('Error', 'QR not found!',
              colorText: Colors.white, backgroundColor: Colors.red);
        }
        update(["incomingQr"]);
      },
    );
  }
  void onQRViewCreatedF2(QRViewController controller) {
    this.controller = controller;

    if (homeFlash == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
          (scanData) async {

        result = scanData;
        String resultData = result?.code ?? "";

        // barcodeData[initialIndex] = {
        //   'name': barcodeData[initialIndex]['name'],
        //   'value': resultData,
        //   'image': resultData,
        // };

        //barcodeData[11]['value'] = resultData;
        barcodeDataImage[11] = resultData;

        isScanHandled = true;
        if (result != null) {
          isBarcode = false;

          map = {
            'barcode': barcodeData[11]['name'],
            'barcode_value': resultData,
            "barcode_image": imageFileList[11].path
          };

          if (imageFileList[11].path != '') {
            await markedVerifiedAPi(map,11);
          }
        } else {

          Get.snackbar('Error', 'QR not found!',
              colorText: Colors.white, backgroundColor: Colors.red);
        }
        update(["incomingQr"]);
      },
    );
  }
  void onQRViewCreatedB1(QRViewController controller) {
    this.controller = controller;

    if (homeFlash == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
          (scanData) async {

        result = scanData;
        String resultData = result?.code ?? "";

        // barcodeData[initialIndex] = {
        //   'name': barcodeData[initialIndex]['name'],
        //   'value': resultData,
        //   'image': resultData,
        // };

        //barcodeData[12]['value'] = resultData;
        barcodeDataImage[12] = resultData;

        isScanHandled = true;
        if (result != null) {
          isBarcode = false;

          map = {
            'barcode': barcodeData[12]['name'],
            'barcode_value': resultData,
            "barcode_image": imageFileList[12].path
          };

          if (imageFileList[12].path != '') {
            await markedVerifiedAPi(map,12);
          }
        } else {

          Get.snackbar('Error', 'QR not found!',
              colorText: Colors.white, backgroundColor: Colors.red);
        }
        update(["incomingQr"]);
      },
    );
  }
  void onQRViewCreatedB2(QRViewController controller) {
    this.controller = controller;

    if (homeFlash == true) {
      controller.toggleFlash();
    } else {}
    controller!.scannedDataStream.listen(
          (scanData) async {

        result = scanData;
        String resultData = result?.code ?? "";

        // barcodeData[initialIndex] = {
        //   'name': barcodeData[initialIndex]['name'],
        //   'value': resultData,
        //   'image': resultData,
        // };

        //barcodeData[13]['value'] = resultData;
        barcodeDataImage[13] = resultData;

        isScanHandled = true;
        if (result != null) {
          isBarcode = false;

          map = {
            'barcode': barcodeData[13]['name'],
            'barcode_value': resultData,
            "barcode_image": imageFileList[13].path
          };

          if (imageFileList[13].path != '') {
            await markedVerifiedAPi(map,13);
          }
        } else {

          Get.snackbar('Error', 'QR not found!',
              colorText: Colors.white, backgroundColor: Colors.red);
        }
        update(["incomingQr"]);
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
  }

  completeTransactionApi() async {
    loader.value = true;
    bool isComplete = await CompleteTransactionApi.completeTransactionApi(
      markedId,
    );
    if (isComplete == true) {
      await Future.delayed(Duration(seconds: 3), () {
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
                  final image = await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 30, );

                  if (image != null) {
                    imageFileList[0] = File(image.path);

                    map = {
                      'barcode': barcodeData[0]['name'],
                      'barcode_value': barcodeDataImage[0],
                      "barcode_image": imageFileList[0].path
                    };

                    if (barcodeDataImage[0] != '' &&
                        imageFileList[0].path != '') {
                      await markedVerifiedAPi(map,0);
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
                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 30);

                  if (image != null) {
                    imageFileList[0] = File(image.path);
                    map = {
                      'barcode': barcodeData[0]['name'],
                      'barcode_value': barcodeDataImage[0],
                      "barcode_image": imageFileList[0].path
                    };

                    if (barcodeDataImage[0] != '' &&
                        imageFileList[0].path != '') {
                      await markedVerifiedAPi(map,0);
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
                  final image = await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 30);

                  if (image != null) {
                    imageFileList[1] = File(image.path);

                    map = {
                      'barcode': barcodeData[1]['name'],
                      'barcode_value': barcodeDataImage[1],
                      "barcode_image": imageFileList[1].path
                    };

                    if (barcodeDataImage[1] != '' &&
                        imageFileList[1].path != '') {
                      await markedVerifiedAPi(map,1);
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
                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 30);

                  if (image != null) {
                    imageFileList[1] = File(image.path);
                    map = {
                      'barcode': barcodeData[1]['name'],
                      'barcode_value': barcodeDataImage[1],
                      "barcode_image": imageFileList[1].path
                    };

                    if (barcodeDataImage[1] != '' &&
                        imageFileList[1].path != '') {
                      await markedVerifiedAPi(map,1);
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
                  final image = await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 30);

                  if (image != null) {
                    imageFileList[2] = File(image.path);

                    map = {
                      'barcode': barcodeData[2]['name'],
                      'barcode_value': barcodeDataImage[2],
                      "barcode_image": imageFileList[2].path
                    };

                    if (barcodeDataImage[2] != '' &&
                        imageFileList[2].path != '') {
                      await markedVerifiedAPi(map,2);
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
                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 30);

                  if (image != null) {
                    imageFileList[2] = File(image.path);
                    map = {
                      'barcode': barcodeData[2]['name'],
                      'barcode_value': barcodeDataImage[2],
                      "barcode_image": imageFileList[2].path
                    };

                    if (barcodeDataImage[2] != '' &&
                        imageFileList[2].path != '') {
                      await markedVerifiedAPi(map,2);
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
                  final image = await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 30);

                  if (image != null) {
                    imageFileList[3] = File(image.path);

                    map = {
                      'barcode': barcodeData[3]['name'],
                      'barcode_value': barcodeDataImage[3],
                      "barcode_image": imageFileList[3].path
                    };

                    if (barcodeDataImage[3] != '' &&
                        imageFileList[3].path != '') {
                      await markedVerifiedAPi(map,3);
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
                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 30);

                  if (image != null) {
                    imageFileList[3] = File(image.path);
                    map = {
                      'barcode': barcodeData[3]['name'],
                      'barcode_value': barcodeDataImage[3],
                      "barcode_image": imageFileList[3].path
                    };

                    if (barcodeDataImage[3] != '' &&
                        imageFileList[3].path != '') {
                      await markedVerifiedAPi(map,3);
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
                  final image = await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 30);

                  if (image != null) {
                    imageFileList[4] = File(image.path);

                    map = {
                      'barcode': barcodeData[4]['name'],
                      'barcode_value': barcodeDataImage[4],
                      "barcode_image": imageFileList[4].path
                    };

                    if (barcodeDataImage[4] != '' &&
                        imageFileList[4].path != '') {
                      await markedVerifiedAPi(map,4);
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
                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 30);

                  if (image != null) {
                    imageFileList[4] = File(image.path);
                    map = {
                      'barcode': barcodeData[4]['name'],
                      'barcode_value': barcodeDataImage[4],
                      "barcode_image": imageFileList[4].path
                    };

                    if (barcodeDataImage[4] != '' &&
                        imageFileList[4].path != '') {
                      await markedVerifiedAPi(map,4);
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
                  final image = await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 30);

                  if (image != null) {
                    imageFileList[5] = File(image.path);

                    map = {
                      'barcode': barcodeData[5]['name'],
                      'barcode_value': barcodeDataImage[5],
                      "barcode_image": imageFileList[5].path
                    };

                    if (barcodeDataImage[5] != '' &&
                        imageFileList[5].path != '') {
                      await markedVerifiedAPi(map,5);
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
                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 30);

                  if (image != null) {
                    imageFileList[5] = File(image.path);
                    map = {
                      'barcode': barcodeData[5]['name'],
                      'barcode_value': barcodeDataImage[5],
                      "barcode_image": imageFileList[5].path
                    };

                    if (barcodeDataImage[5] != '' &&
                        imageFileList[5].path != '') {
                      await markedVerifiedAPi(map,5);
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
                  final image = await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 30);

                  if (image != null) {
                    imageFileList[6] = File(image.path);

                    map = {
                      'barcode': barcodeData[6]['name'],
                      'barcode_value': barcodeDataImage[6],
                      "barcode_image": imageFileList[6].path
                    };

                    if (barcodeDataImage[6] != '' &&
                        imageFileList[6].path != '') {
                      await markedVerifiedAPi(map,6);
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
                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 30);

                  if (image != null) {
                    imageFileList[6] = File(image.path);
                    map = {
                      'barcode': barcodeData[6]['name'],
                      'barcode_value': barcodeDataImage[6],
                      "barcode_image": imageFileList[6].path
                    };

                    if (barcodeDataImage[6] != '' &&
                        imageFileList[6].path != '') {
                      await markedVerifiedAPi(map,6);
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
  imageDialogR3(context) async{
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
                  final image = await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 30);

                  if (image != null) {
                    imageFileList[7] = File(image.path);

                    map = {
                      'barcode': barcodeData[7]['name'],
                      'barcode_value': barcodeDataImage[7],
                      "barcode_image": imageFileList[7].path
                    };

                    if (barcodeDataImage[7] != '' &&
                        imageFileList[7].path != '') {
                      await markedVerifiedAPi(map,7);
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
                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 30);

                  if (image != null) {
                    imageFileList[7] = File(image.path);
                    map = {
                      'barcode': barcodeData[7]['name'],
                      'barcode_value': barcodeDataImage[7],
                      "barcode_image": imageFileList[7].path
                    };

                    if (barcodeDataImage[7] != '' &&
                        imageFileList[7].path != '') {
                      await markedVerifiedAPi(map,7);
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
                  final image = await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 30);

                  if (image != null) {
                    imageFileList[8] = File(image.path);

                    map = {
                      'barcode': barcodeData[8]['name'],
                      'barcode_value': barcodeDataImage[8],
                      "barcode_image": imageFileList[8].path
                    };

                    if (barcodeDataImage[8] != '' &&
                        imageFileList[8].path != '') {
                      await markedVerifiedAPi(map,8);
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
                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 30);

                  if (image != null) {
                    imageFileList[8] = File(image.path);
                    map = {
                      'barcode': barcodeData[8]['name'],
                      'barcode_value': barcodeDataImage[8],
                      "barcode_image": imageFileList[8].path
                    };

                    if (barcodeDataImage[8] != '' &&
                        imageFileList[8].path != '') {
                      await markedVerifiedAPi(map,8);
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
                  final image = await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 30);

                  if (image != null) {
                    imageFileList[9] = File(image.path);

                    map = {
                      'barcode': barcodeData[9]['name'],
                      'barcode_value': barcodeDataImage[9],
                      "barcode_image": imageFileList[9].path
                    };

                    if (barcodeDataImage[9] != '' &&
                        imageFileList[9].path != '') {
                      await markedVerifiedAPi(map,9);
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
                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 30);

                  if (image != null) {
                    imageFileList[9] = File(image.path);
                    map = {
                      'barcode': barcodeData[9]['name'],
                      'barcode_value': barcodeDataImage[9],
                      "barcode_image": imageFileList[9].path
                    };

                    if (barcodeDataImage[9] != '' &&
                        imageFileList[9].path != '') {
                      await markedVerifiedAPi(map,9);
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
                  final image = await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 30);

                  if (image != null) {
                    imageFileList[10] = File(image.path);

                    map = {
                      'barcode': barcodeData[10]['name'],
                      'barcode_value': barcodeDataImage[10],
                      "barcode_image": imageFileList[10].path
                    };

                    if (barcodeDataImage[10] != '' &&
                        imageFileList[10].path != '') {
                      await markedVerifiedAPi(map,10);
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
                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 30);

                  if (image != null) {
                    imageFileList[10] = File(image.path);
                    map = {
                      'barcode': barcodeData[10]['name'],
                      'barcode_value': barcodeDataImage[10],
                      "barcode_image": imageFileList[10].path
                    };

                    if (barcodeDataImage[10] != '' &&
                        imageFileList[10].path != '') {
                      await markedVerifiedAPi(map,10);
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
                  final image = await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 30);

                  if (image != null) {
                    imageFileList[11] = File(image.path);

                    map = {
                      'barcode': barcodeData[11]['name'],
                      'barcode_value': barcodeDataImage[11],
                      "barcode_image": imageFileList[11].path
                    };

                    if (barcodeDataImage[11] != '' &&
                        imageFileList[11].path != '') {
                      await markedVerifiedAPi(map,11);
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
                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 30);

                  if (image != null) {
                    imageFileList[11] = File(image.path);
                    map = {
                      'barcode': barcodeData[11]['name'],
                      'barcode_value': barcodeDataImage[11],
                      "barcode_image": imageFileList[11].path
                    };

                    if (barcodeDataImage[11] != '' &&
                        imageFileList[11].path != '') {
                      await markedVerifiedAPi(map,11);
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

  imageDialogB1(context) async{
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
                  final image = await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 30);

                  if (image != null) {
                    imageFileList[12] = File(image.path);

                    map = {
                      'barcode': barcodeData[12]['name'],
                      'barcode_value': barcodeDataImage[12],
                      "barcode_image": imageFileList[12].path
                    };

                    if (barcodeDataImage[12] != '' &&
                        imageFileList[12].path != '') {
                      await markedVerifiedAPi(map,12);
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
                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 30);

                  if (image != null) {
                    imageFileList[12] = File(image.path);
                    map = {
                      'barcode': barcodeData[12]['name'],
                      'barcode_value': barcodeDataImage[12],
                      "barcode_image": imageFileList[12].path
                    };

                    if (barcodeDataImage[12] != '' &&
                        imageFileList[12].path != '') {
                      await markedVerifiedAPi(map,12);
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
                  final image = await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 30);

                  if (image != null) {
                    imageFileList[13] = File(image.path);

                    map = {
                      'barcode': barcodeData[13]['name'],
                      'barcode_value': barcodeDataImage[13],
                      "barcode_image": imageFileList[13].path
                    };

                    if (barcodeDataImage[13] != '' &&
                        imageFileList[13].path != '') {
                      await markedVerifiedAPi(map,13);
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
                  final image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 30);

                  if (image != null) {
                    imageFileList[13] = File(image.path);
                    map = {
                      'barcode': barcodeData[13]['name'],
                      'barcode_value': barcodeDataImage[13],
                      "barcode_image": imageFileList[13].path
                    };

                    if (barcodeDataImage[13] != '' &&
                        imageFileList[13].path != '') {
                      await markedVerifiedAPi(map,13);
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
