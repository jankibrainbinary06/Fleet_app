import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_project/common/widgets/button.dart';
import 'package:new_project/common/widgets/loader.dart';
import 'package:new_project/common/widgets/new_appbar.dart';
import 'package:new_project/screens/search_result_screen/search_result_controller.dart';
import 'package:new_project/utils/color_res.dart';
import 'package:new_project/utils/fonts.dart';
import 'package:new_project/utils/string_res.dart';
import 'package:new_project/utils/text_styles.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SearchResultScreen extends StatelessWidget {
  SearchResultScreen({Key? key, required this.orgId,required this.id, required this.vehicleNumber})
      : super(key: key);

  final String id;
  final String orgId;
  final String vehicleNumber;

  @override
  Widget build(BuildContext context) {
    final SearchResultController searchResultController =
        Get.put(SearchResultController(id: id));
searchResultController.orgid =orgId;
    return Scaffold(
        backgroundColor: ColorRes.white,
        body: Obx(() {
          return Stack(
            children: [
              GetBuilder<SearchResultController>(
                id: 'qr',
                builder: (controller) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          NewAppBar(
                            text1: Strings.back,
                            text2: '',
                            title: vehicleNumber,
                            ontap1: () {
                              Get.back();
                            },
                            ontap2: () {},
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
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
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          '(2 Photos)',
                                          style: subTitle.copyWith(
                                              color: Colors.blueGrey
                                                  .withOpacity(0.7)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller
                                                .imageDialogForDevicePhotos(
                                                    context, 1);
                                          },
                                          child: controller
                                                  .devicePhoto1.path.isEmpty
                                              ? Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: ColorRes.appPrimary
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8,
                                                      ),
                                                      border: Border.all(
                                                          width: 0.5,
                                                          color: ColorRes
                                                              .appPrimary
                                                              .withOpacity(
                                                                  0.6))),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: ColorRes.appPrimary,
                                                    size: 30,
                                                  ),
                                                )
                                              : ClipRRect(
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
                                                      child: Image.file(
                                                        controller.devicePhoto1,
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller
                                                .imageDialogForDevicePhotos(
                                                    context, 2);
                                          },
                                          child: controller
                                                  .devicePhoto2.path.isEmpty
                                              ? Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: ColorRes.appPrimary
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8,
                                                      ),
                                                      border: Border.all(
                                                          width: 0.5,
                                                          color: ColorRes
                                                              .appPrimary
                                                              .withOpacity(
                                                                  0.6))),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: ColorRes.appPrimary,
                                                    size: 30,
                                                  ),
                                                )
                                              : ClipRRect(
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
                                                      child: Image.file(
                                                        controller.devicePhoto2,
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
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
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          '(Max 8 Photos)',
                                          style: subTitle.copyWith(
                                              color: Colors.blueGrey
                                                  .withOpacity(0.7)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GridView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount:
                                          controller.materialPhotoList.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                      ),
                                      itemBuilder: (context, index) {
                                        return controller
                                                .materialPhotoList[index]
                                                .path
                                                .isEmpty
                                            ? GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .imageDialogForMaterialPhotos(
                                                          context, index);
                                                },
                                                child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: ColorRes.appPrimary
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8,
                                                      ),
                                                      border: Border.all(
                                                          width: 0.5,
                                                          color: ColorRes
                                                              .appPrimary
                                                              .withOpacity(
                                                                  0.6))),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: ColorRes.appPrimary,
                                                    size: 30,
                                                  ),
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  8,
                                                ),
                                                child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: ColorRes.appPrimary
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8,
                                                      ),
                                                      border: Border.all(
                                                          width: 0.5,
                                                          color: ColorRes
                                                              .appPrimary
                                                              .withOpacity(
                                                                  0.6))),
                                                  child: Image.file(
                                                    controller
                                                            .materialPhotoList[
                                                        index],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 45,
                                      width: 170,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: ColorRes.appPrimary,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        'Barcode section',
                                        style: subTitle.copyWith(
                                            color: ColorRes.white),
                                      ),
                                    ),
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
                                    //     ? Row(
                                    //         children: [
                                    //           ClipRRect(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(15),
                                    //             child: Container(
                                    //               decoration: BoxDecoration(
                                    //                   color: Colors.transparent,
                                    //                   borderRadius:
                                    //                       BorderRadius.circular(
                                    //                           15)),
                                    //               margin:
                                    //                   const EdgeInsets.all(2),
                                    //               height: 150,
                                    //               width: 150,
                                    //               child: QRView(
                                    //                   key: controller.qrKey,
                                    //                   onQRViewCreated:
                                    //                       controller
                                    //                           .onQRViewCreated),
                                    //             ),
                                    //           ),
                                    //           SizedBox(
                                    //             width: 10,
                                    //           ),
                                    //           GestureDetector(
                                    //             onTap: () {
                                    //               controller
                                    //                   .imageDialog(context);
                                    //             },
                                    //             child: controller
                                    //                     .imageFileList[
                                    //                         controller
                                    //                             .initialIndex]
                                    //                     .path
                                    //                     .isEmpty
                                    //                 ? Container(
                                    //                     height: 150,
                                    //                     width: 150,
                                    //                     decoration:
                                    //                         BoxDecoration(
                                    //                             color: ColorRes
                                    //                                 .appPrimary
                                    //                                 .withOpacity(
                                    //                                     0.1),
                                    //                             borderRadius:
                                    //                                 BorderRadius
                                    //                                     .circular(
                                    //                               8,
                                    //                             ),
                                    //                             border: Border.all(
                                    //                                 width: 0.5,
                                    //                                 color: ColorRes
                                    //                                     .appPrimary
                                    //                                     .withOpacity(
                                    //                                         0.6))),
                                    //                     child: const Icon(
                                    //                       Icons.image,
                                    //                       color: ColorRes
                                    //                           .appPrimary,
                                    //                       size: 70,
                                    //                     ),
                                    //                   )
                                    //                 : ClipRRect(
                                    //                     borderRadius:
                                    //                         BorderRadius
                                    //                             .circular(8),
                                    //                     child: Container(
                                    //                       height: 150,
                                    //                       width: 150,
                                    //                       decoration:
                                    //                           BoxDecoration(
                                    //                               color: ColorRes
                                    //                                   .appPrimary
                                    //                                   .withOpacity(
                                    //                                       0.1),
                                    //                               borderRadius:
                                    //                                   BorderRadius
                                    //                                       .circular(
                                    //                                 20,
                                    //                               ),
                                    //                               border: Border.all(
                                    //                                   width:
                                    //                                       0.5,
                                    //                                   color: ColorRes
                                    //                                       .appPrimary
                                    //                                       .withOpacity(
                                    //                                           0.6))),
                                    //                       child: Image.file(
                                    //                         controller
                                    //                                 .imageFileList[
                                    //                             controller
                                    //                                 .initialIndex],
                                    //                         fit: BoxFit.cover,
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //           ),
                                    //         ],
                                    //       )
                                    //     : const SizedBox(),
                                    ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        height: 10,
                                      ),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: controller.barcodeData.length,
                                      itemBuilder: (context, index) {
                                        debugPrint(
                                            "=============: ${controller.barcodeDataImage[index]}");
                                        return Column(
                                          children: [
                                            Container(
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
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    controller
                                                        .barcodeData[index]
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
                                                  SizedBox(width: 10),
                                                  controller.barcodeDataImage[
                                                              index] !=
                                                          ''
                                                      ? GestureDetector(
                                                          onTap: () async {
                                                            controller
                                                                .convertImageToFile();
                                                          },
                                                          child: SizedBox(
                                                            height: 100,
                                                            width: 100,
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
                                                            controller
                                                                .update(['qr']);
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
                                                          ''
                                                      ? SizedBox(width: 0)
                                                      : SizedBox(
                                                          width: 10,
                                                        ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller.initialIndex =
                                                          index;
                                                      controller.update(['qr']);
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
                                                            child: const Icon(
                                                              Icons.add,
                                                              color: ColorRes
                                                                  .appPrimary,
                                                              size: 20,
                                                            ))
                                                        : ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
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
                                                                            color: ColorRes.appPrimary.withOpacity(
                                                                                0.6))),
                                                                child:
                                                                    Image.file(
                                                                  controller
                                                                          .imageFileList[
                                                                      index],
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )),
                                                          ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller.selectedData =
                                                          controller
                                                                  .barcodeData[
                                                              index]['name'];
                                                      controller.initialIndex =
                                                          index;
                                                      controller.isBarcode =
                                                          true;
                                                      controller.update(['qr']);
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      width: 70,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                            width: 0.5,
                                                            color: ColorRes
                                                                .appPrimary),
                                                        color: ColorRes
                                                            .appPrimary
                                                            .withOpacity(0.2),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        'Scan',
                                                        style: subTitle,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 7,
                                                  ),
                                                  controller.statusList[
                                                              index] ==
                                                          'error'
                                                      ? Icon(
                                                          Icons.cancel,
                                                          color: Colors.red,
                                                        )
                                                      : controller.statusList[
                                                                  index] ==
                                                              'loader'
                                                          ? CupertinoActivityIndicator(
                                                              color:
                                                                  Colors.black,
                                                            )
                                                          : controller.statusList[
                                                                      index] ==
                                                                  'verified'
                                                              ? Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: Colors
                                                                      .green,
                                                                )
                                                              : SizedBox(
                                                                  width: 25,
                                                                ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            controller.barcodeDataImage[
                                                        index] !=
                                                    ''
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 0.5,
                                                            color: ColorRes
                                                                .appPrimary),
                                                        color: ColorRes
                                                            .appPrimary
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    height: 70,
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        // controller.barcodeDataImage[
                                                        //             index] !=
                                                        //         ''
                                                        //     ? GestureDetector(
                                                        //         onTap:
                                                        //             () async {
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
                                                        //               gapless:
                                                        //                   true,
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
                                                        // controller
                                                        //         .imageFileList[
                                                        //             controller
                                                        //                 .initialIndex]
                                                        //         .path
                                                        //         .isNotEmpty
                                                        //     ? Image.file(
                                                        //         controller
                                                        //                 .imageFileList[
                                                        //             index],
                                                        //         height: 50,
                                                        //         width: 50,
                                                        //         fit: BoxFit
                                                        //             .cover,
                                                        //       )
                                                        //     : SizedBox(),
                                                        // SizedBox(
                                                        //   width: 10,
                                                        // ),
                                                        Expanded(
                                                          child: Text(
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
                                                : SizedBox(),
                                          ],
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CommonButton(
                                          width: 200,
                                          text: Strings.save,
                                          onTap: () {
                                            controller.validation();
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
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
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(15)),
                              height: Get.height,
                              width: Get.width,
                              child: QRView(
                                  key: controller.qrKey,
                                  onQRViewCreated: controller.onQRViewCreated),
                            )
                          : SizedBox(),
                    ],
                  );
                },
              ),
              searchResultController.loader.value
                  ? Center(child: FullScreenLoader())
                  : SizedBox(),
            ],
          );
        }));
  }
}
