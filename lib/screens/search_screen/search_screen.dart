import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:new_project/common/widgets/button.dart';
import 'package:new_project/common/widgets/new_appbar.dart';
import 'package:new_project/common/widgets/text_fields.dart';
import 'package:new_project/screens/search_result_screen/search_result_screen.dart';
import 'package:new_project/screens/search_screen/search_screen_controller.dart';
import 'package:new_project/screens/vehicle_detail_screen/vehicle_detail_screen.dart';
import 'package:new_project/utils/color_res.dart';
import 'package:new_project/utils/string_res.dart';
import 'package:new_project/utils/text_styles.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final SearchController1 controller = Get.put(SearchController1());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: GetBuilder<SearchController1>(
        id: 'search',
        builder: (controller) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  NewAppBar(
                    text1: Strings.back,
                    text2: '',
                    title: Strings.search,
                    ontap1: () {
                      Get.back();
                    },
                    ontap2: () {},
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
                      controller.update(['search']);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      padding: EdgeInsets.symmetric(horizontal: 10),
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
                            controller.selectedOrg,
                            style: subTitle.copyWith(
                                color: controller.selectedOrg == 'Select'
                                    ? Colors.black
                                    : ColorRes.appPrimary),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_drop_down_sharp,
                            size: 30,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      controller.selectedOrg != 'Select'
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: CommonTextField(
                                controller: controller.searchController,
                                hintText: Strings.search,
                                borderRadius: 100,
                                onChanged: (data) async {
                                  controller.isSearching.value =
                                      data.isNotEmpty;
                                  await controller.searchAPi(data);
                                },
                              ),
                            )

                          : SizedBox(),
                      controller.isDrop == true
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  color: ColorRes.appPrimary,
                                  border: Border.all(
                                      color: ColorRes.cE8E8E8, width: 0.4)),
                              child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        controller.selectedOrg = controller
                                                .getAllOrgModel[index]
                                                .companyName ??
                                            "";
                                        controller.selectedOrgId = controller
                                            .getAllOrgModel[index].pk.toString() ??
                                            "";
                                        controller.isDrop = false;
                                        controller.update(['search']);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Text(
                                          controller.getAllOrgModel[index]
                                                  .companyName ??
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
                                        height: 1, color: ColorRes.cE8E8E8);
                                  },
                                  itemCount: controller.getAllOrgModel.length),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Obx(
                    () => controller.isSearching.value &&
                            controller.loader.value == false
                        ? controller.vehicalSearchList.value.isNotEmpty
                            ? Expanded(
                                child: ListView.separated(
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                shrinkWrap: true,
                                itemCount:
                                    controller.vehicalSearchList.value.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() => SearchResultScreen(
                                        orgId:  controller.selectedOrgId,
                                            id: controller
                                                    .vehicalSearchList[index].pk
                                                    .toString() ??
                                                '',
                                            vehicleNumber: controller
                                                    .vehicalSearchList[index]
                                                    .vehicleNo ??
                                                '',
                                          ));
                                    },
                                    child: Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: ColorRes.appPrimary
                                            .withOpacity(0.2),
                                        border: Border.all(
                                          color: ColorRes.appPrimary,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        controller.vehicalSearchList
                                                .value[index].vehicleNo ??
                                            "",
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                  );
                                },
                              ))
                            : Center(
                                child: CommonButton(
                                  width: 200,
                                  height: 50,
                                  text: Strings.createVehicle,
                                  onTap: () {
                                    Get.to(() => VehicleDetailScreen(
                                      orgId:  controller.selectedOrgId,
                                          vehicleNumber:
                                              controller.searchController.text,
                                        ));
                                  },
                                ),
                              )
                        : const SizedBox(),
                  ),
                ],
              ),
              Obx(() => controller.loader.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox()),
            ],
          );
        },
      ),
    );
  }
}
