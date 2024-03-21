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
  VehicleDetailScreen({Key? key,required this.orgId, required this.vehicleNumber})
      : super(key: key);

  final String vehicleNumber;
  final String orgId;
  final VehicleDetailController vehicleDetailController =
      Get.put(VehicleDetailController());
  @override
  Widget build(BuildContext context) {
  vehicleDetailController.orgId =orgId;
    vehicleDetailController.vehicalNumberController.text = vehicleNumber;
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Obx(() {
        return Stack(
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
                            onTap: () {},
                            hintText: Strings.vehicleNUmber,
                            controller: controller.vehicalNumberController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                Strings.vehicleNUmberPhoto,
                                style: subTitle,
                              ),
                              SizedBox(
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
                                        controller.imageDialog(context, 4);
                                      },
                                      child: controller
                                              .vehicleNumberPath.isEmpty
                                          ? Container(
                                              height: 150,
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                  color: ColorRes.appPrimary
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20,
                                                  ),
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color: ColorRes.appPrimary
                                                          .withOpacity(0.6))),
                                              child: const Icon(
                                                Icons.image,
                                                color: ColorRes.appPrimary,
                                                size: 70,
                                              ))
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 150,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                    color: ColorRes.appPrimary
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      20,
                                                    ),
                                                    border: Border.all(
                                                        width: 0.5,
                                                        color: ColorRes
                                                            .appPrimary
                                                            .withOpacity(0.6))),
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
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      vehicleDetailController.imageDialog(
                                          context, 1);
                                    },
                                    child: controller.profileImagePath.isEmpty
                                        ? Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                color: ColorRes.appPrimary
                                                    .withOpacity(0.1),
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    width: 0.5,
                                                    color: ColorRes.appPrimary
                                                        .withOpacity(0.6))),
                                            child: const Icon(
                                              Icons.person,
                                              color: ColorRes.appPrimary,
                                              size: 70,
                                            ))
                                        : ClipOval(
                                            child: Container(
                                              height: 150,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                  color: ColorRes.appPrimary
                                                      .withOpacity(0.1),
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color: ColorRes.appPrimary
                                                          .withOpacity(0.6))),
                                              child: Image.file(
                                                File(
                                                  controller.profileImagePath,
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
                                        controller.imageDialog(context, 2);
                                      },
                                      child: controller.licenceFrontPath.isEmpty
                                          ? Container(
                                              height: 150,
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                  color: ColorRes.appPrimary
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20,
                                                  ),
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color: ColorRes.appPrimary
                                                          .withOpacity(0.6))),
                                              child: const Icon(
                                                Icons.image,
                                                color: ColorRes.appPrimary,
                                                size: 70,
                                              ))
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 150,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                    color: ColorRes.appPrimary
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      20,
                                                    ),
                                                    border: Border.all(
                                                        width: 0.5,
                                                        color: ColorRes
                                                            .appPrimary
                                                            .withOpacity(0.6))),
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
                              SizedBox(
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
                                        controller.imageDialog(context, 3);
                                      },
                                      child: controller.licenceBackPath.isEmpty
                                          ? Container(
                                              height: 150,
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                  color: ColorRes.appPrimary
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20,
                                                  ),
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color: ColorRes.appPrimary
                                                          .withOpacity(0.6))),
                                              child: const Icon(
                                                Icons.image,
                                                color: ColorRes.appPrimary,
                                                size: 70,
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 150,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                    color: ColorRes.appPrimary
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      20,
                                                    ),
                                                    border: Border.all(
                                                        width: 0.5,
                                                        color: ColorRes
                                                            .appPrimary
                                                            .withOpacity(0.6))),
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
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
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
                ? const Center(child: FullScreenLoader())
                : const SizedBox(),
          ],
        );
      }),
    );
  }
}
