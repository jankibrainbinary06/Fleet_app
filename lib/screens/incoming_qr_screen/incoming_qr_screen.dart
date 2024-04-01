import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_project/common/widgets/button.dart';
import 'package:new_project/common/widgets/new_appbar.dart';
import 'package:new_project/screens/incoming_qr_screen/incoming_qr_controller.dart';
import 'package:new_project/screens/search_result_screen/search_result_controller.dart';
import 'package:new_project/utils/color_res.dart';
import 'package:new_project/utils/fonts.dart';
import 'package:new_project/utils/string_res.dart';
import 'package:new_project/utils/text_styles.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class IncomingQRScreen extends StatelessWidget {
  IncomingQRScreen({Key? key, required this.id, required this.vehicleNumber})
      : super(key: key);
  final String id;
  final String vehicleNumber;

  final IncomingQRController incomingQRController =
      Get.put(IncomingQRController());

  bool isApiCall = false;
init() async {
  await incomingQRController.getTransactionApi(id);
  isApiCall = true;

}

  @override
  Widget build(BuildContext context) {
    incomingQRController.markedId = id;

    if (isApiCall == false) {
     init();
    }

    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
          backgroundColor: ColorRes.white,
          body: Stack(
            alignment: Alignment.center,
            children: [
              GetBuilder<IncomingQRController>(
                id: 'incomingQr',
                builder: (controller) {
                  return Stack(
                    children: [
                      controller.isMainFlash == false
                          ? Container(
                              height: 1,
                              width: 1,
                              child: QRView(
                                  key: controller.qrKey,
                                  onQRViewCreated: controller.onQRViewCreated2),
                            )
                          : SizedBox(),
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: Get.width,
                                child: NewAppBar(
                                  text1: Strings.back,
                                  text2: '',
                                  title: vehicleNumber,
                                  ontap1: () {
                                    Get.back();
                                  },
                                  ontap2: () {},
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  controller.isMainFlash = true;

                                  if (controller.homeFlash == true) {
                                    controller.homeFlash = false;
                                  } else {
                                    controller.homeFlash = true;
                                  }
                                  controller.update(['incomingQr']);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10, bottom: 23),
                                  child: controller.homeFlash == true
                                      ? Icon(
                                          Icons.flashlight_on_rounded,
                                          size: 30,
                                        )
                                      : Icon(
                                          Icons.flashlight_off,
                                          size: 30,
                                        ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // controller.isBarcode
                                    //     ? Text(
                                    //         controller.selectedData,
                                    //         style: subTitle.copyWith(
                                    //             fontSize: 20,
                                    //             fontFamily: Fonts.semiBold,
                                    //             fontWeight: FontWeight.w600),
                                    //       )
                                    //     : const SizedBox(),
                                    // controller.isBarcode
                                    //     ? Container(
                                    //         margin: const EdgeInsets.all(2),
                                    //         height: Get.height * 0.32,
                                    //         width: Get.width * 0.64,
                                    //         color: Colors.transparent,
                                    //         child: QRView(
                                    //             key: controller.qrKey,
                                    //             onQRViewCreated:
                                    //                 controller.onQRViewCreated),
                                    //       )
                                    //     : const SizedBox(),
                                    ((controller.dp1 != '') ||
                                            (controller.dp2 != ''))
                                        ? Row(
                                            children: [
                                              Container(
                                                height: 45,
                                                width: 170,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: ColorRes.appPrimary,
                                                    borderRadius:
                                                        BorderRadius.circular(8)),
                                                child: Text(
                                                  'Device photos',
                                                  style: subTitle.copyWith(
                                                      color: ColorRes.white),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                '(2 Photos)',
                                                style: subTitle.copyWith(
                                                    color: Colors.blueGrey
                                                        .withOpacity(0.7)),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    SizedBox(
                                      height: ((controller.dp1 != '') &&
                                              (controller.dp2 != ''))
                                          ? 10
                                          : 0,
                                    ),
                                    ((controller.dp1 != '') ||
                                            (controller.dp2 != ''))
                                        ? Row(
                                            children: [
                                              (controller.dp1 != '')
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8,
                                                      ),
                                                      child: Container(
                                                          height: 100,
                                                          width: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: ColorRes
                                                                      .appPrimary
                                                                      .withOpacity(
                                                                          0.1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    8,
                                                                  ),
                                                                  border: Border.all(
                                                                      width: 0.5,
                                                                      color: ColorRes
                                                                          .appPrimary
                                                                          .withOpacity(
                                                                              0.6))),
                                                          child: (controller
                                                                      .dp2 !=
                                                                  '')
                                                              ? Image.memory(
                                                                  base64Decode(
                                                                      controller
                                                                          .dp1),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              : const SizedBox()),
                                                    )
                                                  : const SizedBox(),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              (controller.dp2 != '')
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8,
                                                      ),
                                                      child: Container(
                                                          height: 100,
                                                          width: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: ColorRes
                                                                      .appPrimary
                                                                      .withOpacity(
                                                                          0.1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    8,
                                                                  ),
                                                                  border: Border.all(
                                                                      width: 0.5,
                                                                      color: ColorRes
                                                                          .appPrimary
                                                                          .withOpacity(
                                                                              0.6))),
                                                          child: (controller
                                                                      .dp2 !=
                                                                  '')
                                                              ? Image.memory(
                                                                  base64Decode(
                                                                      controller
                                                                          .dp2),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              : const SizedBox()),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          )
                                        : const SizedBox(),
                                    SizedBox(
                                      height: ((controller.dp1 != '') ||
                                              (controller.dp2 != ''))
                                          ? 20
                                          : 0,
                                    ),
                                    (controller.materialPhoto.length != 0)
                                        ? Row(
                                            children: [
                                              Container(
                                                height: 45,
                                                width: 170,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: ColorRes.appPrimary,
                                                    borderRadius:
                                                        BorderRadius.circular(8)),
                                                child: Text(
                                                  'Material photos',
                                                  style: subTitle.copyWith(
                                                      color: ColorRes.white),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                '(Max 8 Photos)',
                                                style: subTitle.copyWith(
                                                    color: Colors.blueGrey
                                                        .withOpacity(0.7)),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    SizedBox(
                                      height:
                                          (controller.materialPhoto.length != 0)
                                              ? 10
                                              : 0,
                                    ),

                                    (controller.materialPhoto.length != 0)
                                        ? GridView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount:
                                                controller.materialPhoto.length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                            ),
                                            itemBuilder: (context, index) {
                                              return controller
                                                          .materialPhoto[index] !=
                                                      ''
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8,
                                                      ),
                                                      child: Container(
                                                        height: 100,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color: ColorRes
                                                                .appPrimary
                                                                .withOpacity(0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              8,
                                                            ),
                                                            border: Border.all(
                                                                width: 0.5,
                                                                color: ColorRes
                                                                    .appPrimary
                                                                    .withOpacity(
                                                                        0.6))),
                                                        child: Image.memory(
                                                          base64Decode(controller
                                                                  .materialPhoto[
                                                              index]),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox();
                                            },
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Container(
                                    //   height: 45,
                                    //   width: 170,
                                    //   alignment: Alignment.center,
                                    //   decoration: BoxDecoration(
                                    //       color: ColorRes.appPrimary,
                                    //       borderRadius: BorderRadius.circular(8)),
                                    //   child: Text(
                                    //     'Barcode section',
                                    //     style: subTitle.copyWith(
                                    //         color: ColorRes.white),
                                    //   ),
                                    // ),

                                    /// ---Qr ---
                                    ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        height: 10,
                                      ),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: controller.barcodeData.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color: ColorRes.appPrimary),
                                                  color: ColorRes.appPrimary
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              height: 100,
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    controller.barcodeData[index]
                                                            ['name']
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: subTitle.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            Fonts.semiBold,
                                                        fontSize: 18),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  // controller.barcodeDataImage[
                                                  //                 index] !=
                                                  //             '' &&
                                                  //         controller.statusList[
                                                  //                 index] !=
                                                  //             'error'
                                                  //     ?
                                                  // GestureDetector(
                                                  //         onTap: () async {
                                                  //           controller
                                                  //               .convertImageToFile();
                                                  //         },
                                                  //         child: SizedBox(
                                                  //           height: 80,
                                                  //           width: 80,
                                                  //           child: Center(
                                                  //             child:
                                                  //                 // Image.memory(
                                                  //                 //     Uint8List.fromList([64, 117, 21, 34, 4, 52, 244, 68, 80, 236, 17, 236, 17, 236, 17, 236, 17, 236, 17])
                                                  //                 //
                                                  //                 // )
                                                  //                 QrImageView(
                                                  //               version:
                                                  //                   QrVersions.auto,
                                                  //               gapless: true,
                                                  //               data: controller
                                                  //                       .barcodeDataImage[
                                                  //                   index],
                                                  //               size: Get.width * .6,
                                                  //               backgroundColor:
                                                  //                   Colors
                                                  //                       .transparent,
                                                  //             ),
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     :
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 80,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                          color: ColorRes
                                                              .appPrimary
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            5,
                                                          ),
                                                          border: Border.all(
                                                              width: 0.5,
                                                              color: ColorRes
                                                                  .appPrimary
                                                                  .withOpacity(
                                                                      0.6))),
                                                      alignment: Alignment.center,
                                                      // child: Text(
                                                      //   'Api Image',
                                                      //   style: subTitle,
                                                      // ),
                                                      child: (controller
                                                                  .barcodeData[index]
                                                                      ['image']
                                                                  .toString() !=
                                                              '')
                                                          ?

                                                          // base64Decode(controller
                                                          //     .barcodeData[
                                                          // index]['image']).toString().contains('base64,')?
                                                          // Image.memory(
                                                          //   base64Decode(controller
                                                          //       .barcodeData[
                                                          //   index]['image'].replaceAll(RegExp('^data:image\\/\\w+;base64,'), '')),
                                                          //   fit: BoxFit.cover,
                                                          // ):
                                                          Image.memory(
                                                              base64Decode(controller
                                                                  .barcodeData[
                                                                      index]
                                                                      ['image']
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          '^data:image\\/\\w+;base64,'),
                                                                      '')),
                                                              fit:
                                                                  BoxFit.fitWidth,
                                                              height: 80,
                                                              width: 80,
                                                            )
                                                          : const SizedBox(),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 80,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                          color: ColorRes
                                                              .appPrimary
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            5,
                                                          ),
                                                          border: Border.all(
                                                              width: 0.5,
                                                              color: ColorRes
                                                                  .appPrimary
                                                                  .withOpacity(
                                                                      0.6))),
                                                      alignment: Alignment.center,
                                                      // child: Text(
                                                      //   'Api Image',
                                                      //   style: subTitle,
                                                      // ),
                                                      child: (controller
                                                                  .barcodeData[
                                                                      index][
                                                                      'apiQRImage']
                                                                  .toString() !=
                                                              '')
                                                          ?

                                                          // base64Decode(controller
                                                          //     .barcodeData[
                                                          // index]['image']).toString().contains('base64,')?
                                                          // Image.memory(
                                                          //   base64Decode(controller
                                                          //       .barcodeData[
                                                          //   index]['image'].replaceAll(RegExp('^data:image\\/\\w+;base64,'), '')),
                                                          //   fit: BoxFit.cover,
                                                          // ):
                                                          Image.memory(
                                                              base64Decode(controller
                                                                  .barcodeData[
                                                                      index][
                                                                      'apiQRImage']
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          '^data:image\\/\\w+;base64,'),
                                                                      '')),
                                                              fit: BoxFit.cover,
                                                            )
                                                          : const SizedBox(),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  /* GestureDetector(
                                                    onTap: () {
                                                      controller.selectedData =
                                                          controller
                                                                  .barcodeData[index]
                                                              ['name'];
                                                      controller.initialIndex = index;
                                                      controller.isBarcode = true;
                                                      controller
                                                          .update(['incomingQr']);
                                                    },
                                                    child: Container(
                                                      height: 25,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(8),
                                                        border: Border.all(
                                                            width: 0.5,
                                                            color:
                                                                ColorRes.appPrimary),
                                                        color: ColorRes.appPrimary
                                                            .withOpacity(0.2),
                                                      ),
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        'Scan',
                                                        style: subTitle,
                                                      ),
                                                    ),
                                                  ),*/
                                                  const SizedBox(
                                                    width: 7,
                                                  ),
                                                  // controller.statusList[index] ==
                                                  //         'error'
                                                  //     ? Icon(
                                                  //         Icons.cancel,
                                                  //         color: Colors.red,
                                                  //       )
                                                  //     : controller.statusList[
                                                  //                 index] ==
                                                  //             'loader'
                                                  //         ? CupertinoActivityIndicator(
                                                  //             color: Colors.black,
                                                  //           )
                                                  //         : controller.statusList[
                                                  //                     index] ==
                                                  //                 'verified'
                                                  //             ? Icon(
                                                  //                 Icons.check_circle,
                                                  //                 color: Colors.green,
                                                  //               )
                                                  //             : SizedBox(
                                                  //                 width: 25,
                                                  //               ),
                                                  // SizedBox(
                                                  //   width: 10,
                                                  // ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            /*   controller.barcodeDataImage[index] !=
                                                        '' &&
                                                    controller.statusList[index] !=
                                                        'error'
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 0.5,
                                                            color:
                                                                ColorRes.appPrimary),
                                                        color: ColorRes.appPrimary
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius.circular(8)),
                                                    height: 100,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        controller.barcodeDataImage[
                                                                        index] !=
                                                                    '' &&
                                                                controller.statusList[
                                                                        index] !=
                                                                    'error'
                                                            ? GestureDetector(
                                                                onTap: () async {
                                                                  controller
                                                                      .convertImageToFile();
                                                                },
                                                                child: SizedBox(
                                                                  height: 80,
                                                                  width: 80,
                                                                  child: Center(
                                                                    child:
                                                                        // Image.memory(
                                                                        //     Uint8List.fromList([64, 117, 21, 34, 4, 52, 244, 68, 80, 236, 17, 236, 17, 236, 17, 236, 17, 236, 17])
                                                                        //
                                                                        // )
                                                                        QrImageView(
                                                                      version:
                                                                          QrVersions
                                                                              .auto,
                                                                      gapless: true,
                                                                      data: controller
                                                                              .barcodeDataImage[
                                                                          index],
                                                                      size:
                                                                          Get.width *
                                                                              .6,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : GestureDetector(
                                                                onTap: () {
                                                                  controller
                                                                      .selectedData = controller
                                                                          .barcodeData[
                                                                      index]['name'];
                                                                  controller
                                                                          .initialIndex =
                                                                      index;
                                                                  controller
                                                                          .isBarcode =
                                                                      true;
                                                                  controller.update(
                                                                      ['incomingQr']);
                                                                },
                                                                child: Container(
                                                                  height: 80,
                                                                  width: 80,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: ColorRes
                                                                              .appPrimary
                                                                              .withOpacity(
                                                                                  0.1),
                                                                          borderRadius:
                                                                              BorderRadius
                                                                                  .circular(
                                                                            5,
                                                                          ),
                                                                          border: Border.all(
                                                                              width:
                                                                                  0.5,
                                                                              color: ColorRes
                                                                                  .appPrimary
                                                                                  .withOpacity(0.6))),
                                                                  alignment: Alignment
                                                                      .center,
                                                                  child: Text(
                                                                    'Scan',
                                                                    style: subTitle,
                                                                  ),
                                                                ),
                                                              ),
                                                        controller.barcodeDataImage[
                                                                        index] !=
                                                                    '' &&
                                                                controller.statusList[
                                                                        index] !=
                                                                    'error'
                                                            ? SizedBox(
                                                                width: 0,
                                                              )
                                                            : SizedBox(
                                                                width: 10,
                                                              ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            controller.initialIndex =
                                                                index;
                                                            controller.update(
                                                                ['incomingQr']);
                                                            controller
                                                                .imageDialog(context);
                                                          },
                                                          child: controller
                                                                  .imageFileList[
                                                                      index]
                                                                  .path
                                                                  .isEmpty
                                                              ? Container(
                                                                  height: 80,
                                                                  width: 80,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: ColorRes
                                                                              .appPrimary
                                                                              .withOpacity(
                                                                                  0.1),
                                                                          borderRadius:
                                                                              BorderRadius
                                                                                  .circular(
                                                                            5,
                                                                          ),
                                                                          border: Border.all(
                                                                              width:
                                                                                  0.5,
                                                                              color: ColorRes
                                                                                  .appPrimary
                                                                                  .withOpacity(0.6))),
                                                                  alignment: Alignment
                                                                      .center,
                                                                  child: Text(
                                                                    '+',
                                                                    style: subTitle,
                                                                  ),
                                                                )
                                                              : Container(
                                                                  height: 80,
                                                                  width: 80,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: ColorRes
                                                                              .appPrimary
                                                                              .withOpacity(
                                                                                  0.1),
                                                                          borderRadius:
                                                                              BorderRadius
                                                                                  .circular(
                                                                            5,
                                                                          ),
                                                                          border: Border.all(
                                                                              width:
                                                                                  0.5,
                                                                              color: ColorRes
                                                                                  .appPrimary
                                                                                  .withOpacity(0.6))),
                                                                  alignment: Alignment
                                                                      .center,
                                                                  child: ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      5,
                                                                    ),
                                                                    child: Image.file(
                                                                      controller
                                                                              .imageFileList[
                                                                          index],
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      height: 80,
                                                                      width: 80,
                                                                    ),
                                                                  ),
                                                                ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox(),*/

                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color: ColorRes.appPrimary),
                                                  color: ColorRes.appPrimary
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              height: 100,
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    controller.barcodeData[index]
                                                            ['name']
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: subTitle.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            Fonts.semiBold,
                                                        fontSize: 18),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),

                                                  /// ---- scan barcode -----
                                                  controller.barcodeDataImage[
                                                                  index] !=
                                                              '' &&
                                                          controller.statusList[
                                                                  index] !=
                                                              'error'
                                                      ? GestureDetector(
                                                          onTap: () async {
                                                            controller
                                                                .convertImageToFile();
                                                          },
                                                          child: SizedBox(
                                                            height: 80,
                                                            width: 80,
                                                            child: Center(
                                                              child:
                                                                  // Image.memory(
                                                                  //     Uint8List.fromList([64, 117, 21, 34, 4, 52, 244, 68, 80, 236, 17, 236, 17, 236, 17, 236, 17, 236, 17])
                                                                  //
                                                                  // )
                                                                  QrImageView(
                                                                version:
                                                                    QrVersions
                                                                        .auto,
                                                                gapless: true,
                                                                data: controller
                                                                        .barcodeDataImage[
                                                                    index],
                                                                size: Get.width *
                                                                    .6,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                    .selectedData =
                                                                controller
                                                                        .barcodeData[
                                                                    index]['name'];
                                                            controller
                                                                    .initialIndex =
                                                                index;
                                                            controller.isBarcode =
                                                                true;

                                                            if (controller
                                                                    .homeFlash ==
                                                                true) {
                                                              controller.isFlash =
                                                                  true;
                                                            } else {
                                                              controller.isFlash =
                                                                  false;
                                                            }

                                                            controller.update(
                                                                ['incomingQr']);
                                                          },
                                                          child: Container(
                                                            height: 80,
                                                            width: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: ColorRes
                                                                        .appPrimary
                                                                        .withOpacity(
                                                                            0.1),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      5,
                                                                    ),
                                                                    border: Border.all(
                                                                        width:
                                                                            0.5,
                                                                        color: ColorRes
                                                                            .appPrimary
                                                                            .withOpacity(
                                                                                0.6))),
                                                            alignment:
                                                                Alignment.center,
                                                            child: Text(
                                                              'Scan',
                                                              style: subTitle,
                                                            ),
                                                          ),
                                                        ),
                                                  controller.barcodeDataImage[
                                                                  index] !=
                                                              '' &&
                                                          controller.statusList[
                                                                  index] !=
                                                              'error'
                                                      ? const SizedBox(
                                                          width: 0,
                                                        )
                                                      : const SizedBox(
                                                          width: 10,
                                                        ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller.initialIndex =
                                                          index;
                                                      controller
                                                          .update(['incomingQr']);
                                                      controller
                                                          .chooseImageUpload(context);
                                                    },
                                                    child: controller
                                                            .imageFileList[index]
                                                            .path
                                                            .isEmpty
                                                        ? Container(
                                                            height: 80,
                                                            width: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: ColorRes
                                                                        .appPrimary
                                                                        .withOpacity(
                                                                            0.1),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      5,
                                                                    ),
                                                                    border: Border.all(
                                                                        width:
                                                                            0.5,
                                                                        color: ColorRes
                                                                            .appPrimary
                                                                            .withOpacity(
                                                                                0.6))),
                                                            alignment:
                                                                Alignment.center,
                                                            child: Text(
                                                              '+',
                                                              style: subTitle,
                                                            ),
                                                          )
                                                        : Container(
                                                            height: 80,
                                                            width: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: ColorRes
                                                                        .appPrimary
                                                                        .withOpacity(
                                                                            0.1),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      5,
                                                                    ),
                                                                    border: Border.all(
                                                                        width:
                                                                            0.5,
                                                                        color: ColorRes
                                                                            .appPrimary
                                                                            .withOpacity(
                                                                                0.6))),
                                                            alignment:
                                                                Alignment.center,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                5,
                                                              ),
                                                              child: Image.file(
                                                                controller
                                                                        .imageFileList[
                                                                    index],
                                                                fit: BoxFit.cover,
                                                                height: 80,
                                                                width: 80,
                                                              ),
                                                            ),
                                                          ),
                                                  ),
                                                  const Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller.selectedData =
                                                          controller.barcodeData[
                                                              index]['name'];
                                                      controller.initialIndex =
                                                          index;
                                                      controller.isBarcode = true;

                                                      if (controller.homeFlash ==
                                                          true) {
                                                        controller.isFlash = true;
                                                      } else {
                                                        controller.isFlash =
                                                            false;
                                                      }
                                                      controller
                                                          .update(['incomingQr']);
                                                    },
                                                    child: Container(
                                                      height: 25,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                8),
                                                        border: Border.all(
                                                            width: 0.5,
                                                            color: ColorRes
                                                                .appPrimary),
                                                        color: ColorRes.appPrimary
                                                            .withOpacity(0.2),
                                                      ),
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        'Scan',
                                                        style: subTitle,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  controller.statusList[index] ==
                                                          'error'
                                                      ? const Icon(
                                                          Icons.cancel,
                                                          color: Colors.red,
                                                        )
                                                      : controller.statusList[
                                                                  index] ==
                                                              'loader'
                                                          ? const CupertinoActivityIndicator(
                                                              color: Colors.black,
                                                            )
                                                          : controller.statusList[
                                                                      index] ==
                                                                  'verified'
                                                              ? const Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: Colors
                                                                      .green,
                                                                )
                                                              : const SizedBox(
                                                                  width: 0,
                                                                ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            (controller.barcodeData[index]
                                                            ['value'] !=
                                                        '' &&
                                                    controller
                                                            .statusList[index] !=
                                                        'error')
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 0.5,
                                                            color: ColorRes
                                                                .appPrimary),
                                                        color: ColorRes.appPrimary
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                8)),
                                                    height: 60,
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          controller
                                                              .barcodeData[index]
                                                                  ['value']
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: subTitle.copyWith(
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              fontFamily:
                                                                  Fonts.semiBold,
                                                              fontSize: 18),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox(),
                                            /*       controller.barcodeDataImage[index] !=
                                                        '' &&
                                                    controller.statusList[index] !=
                                                        'error'
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 0.5,
                                                            color:
                                                                ColorRes.appPrimary),
                                                        color: ColorRes.appPrimary
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius.circular(8)),
                                                    height: 50,
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        // controller.barcodeDataImage[
                                                        //             index] !=
                                                        //         ''
                                                        //     ? GestureDetector(
                                                        //         onTap: () async {
                                                        //           controller
                                                        //               .convertImageToFile();
                                                        //         },
                                                        //         child: SizedBox(
                                                        //           height: 100,
                                                        //           width: 100,
                                                        //           child: Center(
                                                        //             child:
                                                        //                 // Image.memory(
                                                        //                 //     Uint8List.fromList([64, 117, 21, 34, 4, 52, 244, 68, 80, 236, 17, 236, 17, 236, 17, 236, 17, 236, 17])
                                                        //                 //
                                                        //                 // )
                                                        //                 QrImageView(
                                                        //               version:
                                                        //                   QrVersions
                                                        //                       .auto,
                                                        //               gapless: true,
                                                        //               data: controller
                                                        //                       .barcodeDataImage[
                                                        //                   index],
                                                        //               size:
                                                        //                   Get.width *
                                                        //                       .6,
                                                        //               backgroundColor:
                                                        //                   Colors
                                                        //                       .transparent,
                                                        //             ),
                                                        //           ),
                                                        //         ),
                                                        //       )
                                                        //     : const SizedBox(),
                                                        Expanded(
                                                          child: Text(
                                                            'Value: ' +
                                                                controller
                                                                        .barcodeData[
                                                                    index]['value'],
                                                            style: subTitle,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox(),*/
                                          ],
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child:  Obx(() {
                                        return CommonButton(
                                          width: 200,
                                          text: 'Submit',
                                          color:
                                          controller.isButtonEnabled.value
                                              ? ColorRes.appPrimary
                                              : ColorRes.cBDBDBD,
                                          onTap: controller
                                              .isButtonEnabled.value
                                              ? () {


                                            print(
                                                "```````````````` */*/*/*/*/*/*/*/*/ ````````````````````");
                                            // Get.back();
                                            // final SearchController1 search = Get.put(SearchController1());
                                            // search.searchController.clear();
                                            // search.update(['search']);
                                            controller.completeTransactionApi();
                                          }
                                              : () {},
                                        );
                                      }),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      controller.isBarcode
                          ? WillPopScope(
                              onWillPop: () async {
                                controller.isBarcode = false;
                                controller.update(['incomingQr']);
                                return false;
                              },
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    height: Get.height,
                                    width: Get.width,
                                    color: Colors.transparent,
                                    child:  controller.qrView(),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 40, right: 20),
                                    child: GestureDetector(
                                      onTap: () async {
                                        controller.controller!.toggleFlash();
                                        if (controller.isFlash == true) {
                                          controller.isFlash = false;
                                        } else {
                                          controller.isFlash = true;
                                        }
                                        controller.update(['incomingQr']);
                                      },
                                      child: Container(
                                        height: 60,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: ColorRes.appPrimary,
                                            shape: BoxShape.circle),
                                        child: controller.isFlash == true
                                            ? Icon(
                                                Icons.flashlight_on_rounded,
                                                size: 30,
                                              )
                                            : Icon(
                                                Icons.flashlight_off,
                                                size: 30,
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                    ],
                  );
                },
              ),
              Obx(() => incomingQRController.loader.value
                  ? const CircularProgressIndicator()
                  : const SizedBox())
            ],
          )),
    );
  }
}
