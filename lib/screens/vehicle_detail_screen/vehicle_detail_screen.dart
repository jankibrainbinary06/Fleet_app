import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:new_project/common/widgets/button.dart';
import 'package:new_project/common/widgets/loader.dart';
import 'package:new_project/common/widgets/new_appbar.dart';
import 'package:new_project/common/widgets/text_fields.dart';
import 'package:new_project/screens/vehicle_detail_screen/vehicle_detail_controller.dart';
import 'package:new_project/utils/asset_res.dart';
import 'package:new_project/utils/color_res.dart';
import 'package:new_project/utils/string_res.dart';
import 'package:new_project/utils/text_styles.dart';

class VehicleDetailScreen extends StatelessWidget {
  VehicleDetailScreen(
      {Key? key, required this.orgId, required this.vehicleNumber})
      : super(key: key);

  final String vehicleNumber;
  final String orgId;
  final VehicleDetailController vehicleDetailController =
      Get.put(VehicleDetailController());

  @override
  Widget build(BuildContext context) {
    vehicleDetailController.orgId = orgId;
    vehicleDetailController.vehicalNumberController.text = vehicleNumber;
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorRes.white,
        body: Obx(() {
          return SingleChildScrollView(
            child: Stack(
              children: [
                GetBuilder<VehicleDetailController>(
                  id: 'vehicle',
                  builder: (controller) {
                    return Column(
                      children: [
                        NewAppBar(
                          text1: Strings.back,
                          text2: '',
                          title: Strings.vehicleDetail,
                          ontap1: () {
                            Get.back();
                          },
                          ontap2: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              CommonTextField(
                                isReadOnly: true,
                                borderRadius: 30,
                                isNumberPlat: true,
                                onTap: () {},
                                hintText: Strings.vehicleNUmber,
                                controller: controller.vehicalNumberController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (controller.isDrop) {
                                    controller.isDrop = false;
                                  } else {
                                    controller.isDrop = true;
                                  }
                                  controller.update(['vehicle']);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 16),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  height: 47,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        5,
                                      ),
                                      color: ColorRes.appPrimary.withOpacity(
                                        0.1,
                                      ),
                                      border: Border.all(
                                          color: ColorRes.appPrimary, width: 0.4)),
                                  child: Row(
                                    children: [
                                      Text(
                                        controller.selectedName,
                                        style: subTitle.copyWith(
                                            color:
                                                controller.selectedName == 'Select'
                                                    ? Colors.black
                                                    : ColorRes.appPrimary),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_drop_down_sharp,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Stack(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            Strings.vehicleNUmberPhoto,
                                            style: subTitle,
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            Strings.driverPhoto,
                                            style: subTitle,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.imageDialog(
                                                        context, 4);
                                                  },
                                                  child: controller
                                                          .vehicleNumberPath.isEmpty
                                                      ? Container(
                                                          height: 150,
                                                          width: Get.width,
                                                          decoration: BoxDecoration(
                                                              color: ColorRes
                                                                  .appPrimary
                                                                  .withOpacity(0.1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                20,
                                                              ),
                                                              border: Border.all(
                                                                  width: 0.5,
                                                                  color: ColorRes
                                                                      .appPrimary
                                                                      .withOpacity(
                                                                          0.6))),
                                                          child: const Icon(
                                                            Icons.image,
                                                            color:
                                                                ColorRes.appPrimary,
                                                            size: 70,
                                                          ))
                                                      : ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  20),
                                                          child: Container(
                                                            height: 150,
                                                            width: Get.width,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: ColorRes
                                                                        .appPrimary
                                                                        .withOpacity(
                                                                            0.1),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      20,
                                                                    ),
                                                                    border: Border.all(
                                                                        width: 0.5,
                                                                        color: ColorRes
                                                                            .appPrimary
                                                                            .withOpacity(
                                                                                0.6))),
                                                            child: Image.file(
                                                              File(controller
                                                                  .vehicleNumberPath),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  vehicleDetailController
                                                      .imageDialog(context, 1);
                                                },
                                                child: controller
                                                        .profileImagePath.isEmpty
                                                    ? Container(
                                                        height: 150,
                                                        width: 150,
                                                        decoration: BoxDecoration(
                                                            color: ColorRes
                                                                .appPrimary
                                                                .withOpacity(0.1),
                                                            shape: BoxShape.circle,
                                                            border: Border.all(
                                                                width: 0.5,
                                                                color: ColorRes
                                                                    .appPrimary
                                                                    .withOpacity(
                                                                        0.6))),
                                                        child: const Icon(
                                                          Icons.person,
                                                          color:
                                                              ColorRes.appPrimary,
                                                          size: 70,
                                                        ))
                                                    : ClipOval(
                                                        child: Container(
                                                          height: 150,
                                                          width: 150,
                                                          decoration: BoxDecoration(
                                                              color: ColorRes
                                                                  .appPrimary
                                                                  .withOpacity(0.1),
                                                              shape:
                                                                  BoxShape.circle,
                                                              border: Border.all(
                                                                  width: 0.5,
                                                                  color: ColorRes
                                                                      .appPrimary
                                                                      .withOpacity(
                                                                          0.6))),
                                                          child: Image.file(
                                                            File(
                                                              controller
                                                                  .profileImagePath,
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            Strings.licenceFrontPic,
                                            style: subTitle,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            Strings.licenceBackPic,
                                            style: subTitle,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.imageDialog(
                                                        context, 2);
                                                  },
                                                  child: controller
                                                          .licenceFrontPath.isEmpty
                                                      ? Container(
                                                          height: 150,
                                                          width: Get.width,
                                                          decoration: BoxDecoration(
                                                              color: ColorRes
                                                                  .appPrimary
                                                                  .withOpacity(0.1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                20,
                                                              ),
                                                              border: Border.all(
                                                                  width: 0.5,
                                                                  color: ColorRes
                                                                      .appPrimary
                                                                      .withOpacity(
                                                                          0.6))),
                                                          child: const Icon(
                                                            Icons.image,
                                                            color:
                                                                ColorRes.appPrimary,
                                                            size: 70,
                                                          ))
                                                      : ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  20),
                                                          child: Container(
                                                            height: 150,
                                                            width: Get.width,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: ColorRes
                                                                        .appPrimary
                                                                        .withOpacity(
                                                                            0.1),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      20,
                                                                    ),
                                                                    border: Border.all(
                                                                        width: 0.5,
                                                                        color: ColorRes
                                                                            .appPrimary
                                                                            .withOpacity(
                                                                                0.6))),
                                                            child: Image.file(
                                                              File(controller
                                                                  .licenceFrontPath),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.imageDialog(
                                                        context, 3);
                                                  },
                                                  child: controller
                                                          .licenceBackPath.isEmpty
                                                      ? Container(
                                                          height: 150,
                                                          width: Get.width,
                                                          decoration: BoxDecoration(
                                                              color: ColorRes
                                                                  .appPrimary
                                                                  .withOpacity(0.1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                20,
                                                              ),
                                                              border: Border.all(
                                                                  width: 0.5,
                                                                  color: ColorRes
                                                                      .appPrimary
                                                                      .withOpacity(
                                                                          0.6))),
                                                          child: const Icon(
                                                            Icons.image,
                                                            color:
                                                                ColorRes.appPrimary,
                                                            size: 70,
                                                          ),
                                                        )
                                                      : ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  20),
                                                          child: Container(
                                                            height: 150,
                                                            width: Get.width,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: ColorRes
                                                                        .appPrimary
                                                                        .withOpacity(
                                                                            0.1),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      20,
                                                                    ),
                                                                    border: Border.all(
                                                                        width: 0.5,
                                                                        color: ColorRes
                                                                            .appPrimary
                                                                            .withOpacity(
                                                                                0.6))),
                                                            child: Image.file(
                                                              File(controller
                                                                  .licenceBackPath),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  controller.isDrop == true
                                      ? Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                5,
                                              ),
                                              color: ColorRes.appPrimary,
                                              border: Border.all(
                                                  color: ColorRes.cE8E8E8,
                                                  width: 0.4)),
                                          child: ListView.separated(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    if (controller.getTransporters[
                                                            index] ==
                                                        '+ Add New') {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return Dialog(
                                                            child: Container(
                                                              height: 200,
                                                              width: 360.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  10,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      'Add Name',
                                                                      style: blackSubTitle
                                                                          .copyWith(
                                                                              fontSize:
                                                                                  20),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 20,
                                                                    ),
                                                                    CommonTextField(
                                                                      controller:
                                                                          controller
                                                                              .transporterNameController,
                                                                      hintText:
                                                                          'Transporter name',
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 20,
                                                                    ),
                                                                    CommonButton(
                                                                      width: 200,
                                                                      height: 70,
                                                                      text: Strings
                                                                          .save,
                                                                      onTap: () {
                                                                        List list =
                                                                            [];
                                                                        for (int i =
                                                                                0;
                                                                            i < controller.getTransporters.length;
                                                                            i++) {
                                                                          if (controller
                                                                                  .getTransporters[i] !=
                                                                              '+ Add New') {
                                                                            list.add(
                                                                                controller.getTransporters[i]);
                                                                          }
                                                                        }

                                                                        controller
                                                                                .getTransporters =
                                                                            list;
                                                                        controller
                                                                            .getTransporters
                                                                            .add(controller
                                                                                .transporterNameController
                                                                                .text);
                                                                        controller
                                                                            .getTransporters
                                                                            .add(
                                                                                '+ Add New');
                                                                        controller
                                                                                .selectedName =
                                                                            controller
                                                                                .transporterNameController
                                                                                .text;
                                                                        controller
                                                                                .isDrop =
                                                                            false;
                                                                        controller
                                                                            .update([
                                                                          'vehicle'
                                                                        ]);
                                                                        Get.back();
                                                                        controller
                                                                            .transporterNameController
                                                                            .clear();
                                                                      },
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 10,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      controller
                                                          .selectedName = controller
                                                                  .getTransporters[
                                                              index] ??
                                                          "";

                                                      controller.isDrop = false;
                                                      controller
                                                          .update(['vehicle']);
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                    ),
                                                    child: Text(
                                                      controller.getTransporters[
                                                              index] ??
                                                          '',
                                                      style: subTitle.copyWith(
                                                        color: ColorRes.white,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder: (context, index) {
                                                return Container(
                                                    height: 1,
                                                    color: ColorRes.cE8E8E8);
                                              },
                                              itemCount: controller
                                                  .getTransporters.length),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),

                        CommonButton(
                          width: 200,
                          text: Strings.save,
                          onTap: () async {
                            if (controller.validation()) {
                              await controller.saveVehical();
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
                vehicleDetailController.loader.value
                    ? const Center(
                        child: FullScreenLoader(
                        enableBgColor: true,
                      ))
                    : const SizedBox(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
