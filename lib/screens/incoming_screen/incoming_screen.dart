import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_project/common/widgets/loader.dart';
import 'package:new_project/common/widgets/new_appbar.dart';
import 'package:new_project/common/widgets/text_fields.dart';
import 'package:new_project/global.dart';
import 'package:new_project/screens/incoming_qr_screen/incoming_qr_controller.dart';
import 'package:new_project/screens/incoming_qr_screen/incoming_qr_screen.dart';
import 'package:new_project/screens/incoming_screen/incoming_controller.dart';
import 'package:new_project/screens/search_screen/search_screen.dart';
import 'package:new_project/utils/color_res.dart';
import 'package:new_project/utils/string_res.dart';

class IncomingScreen extends StatefulWidget {
  IncomingScreen({Key? key}) : super(key: key);

  @override
  State<IncomingScreen> createState() => _IncomingScreenState();
}

class _IncomingScreenState extends State<IncomingScreen> {
  final IncomingController incomingController = Get.put(IncomingController());

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorRes.white,
        body: Obx(() {
          return Stack(
            children: [
              Column(
                children: [
                  NewAppBar(
                    text1: Strings.back,
                    text2: '',
                    title: Strings.incoming,
                    ontap1: () {
                      Get.back();
                    },
                    ontap2: () {},
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16),
                    child: CommonTextField(
                      controller: incomingController.searchController,
                      hintText: Strings.search,
                      isNumberPlat: true,
                      borderRadius: 100,
                      onChanged: (data)  {

                        incomingController.onChange(data);
                        setState((){});
                      },
                    ),
                  ),
                  (incomingController.searchController.text !='')?
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        shrinkWrap: true,
                        itemCount: incomingController.getIncomingListSearch.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              final IncomingQRController incomingQRController =
                              Get.put(IncomingQRController(markedId: incomingController
                                  .getIncomingListSearch[index].pk
                                  .toString()));
                              incomingQRController.getTransactionApi(incomingController
                                  .getIncomingListSearch[index].pk
                                  .toString());


                              Get.to( IncomingQRScreen(
                                id: incomingController
                                    .getIncomingListSearch[index].pk
                                    .toString(),
                                vehicleNumber: incomingController
                                    .getIncomingListSearch[index]
                                    .vehicleVehicleNo ??
                                    '',
                              ));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              height: 70,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: ColorRes.appPrimary.withOpacity(0.2),
                                border: Border.all(
                                  color: ColorRes.appPrimary,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${Strings.pk} : ${incomingController.getIncomingListSearch[index].pk.toString() ?? ''}',
                                    style:
                                    const TextStyle(color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    '${Strings.vehicleNUmber} : ${incomingController.getIncomingListSearch[index].vehicleVehicleNo ?? ''}',
                                    style:
                                    const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                      :Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        shrinkWrap: true,
                        itemCount: incomingController.getIncomingList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          FocusScope.of(context).unfocus();
                          return GestureDetector(
                            onTap: () {
                              final IncomingQRController incomingQRController =
                              Get.put(IncomingQRController(markedId: incomingController
                                  .getIncomingList[index].pk
                                  .toString()));
                              incomingQRController.getTransactionApi(incomingController
                                  .getIncomingList[index].pk
                                  .toString());


                              Get.to( IncomingQRScreen(
                                    id: incomingController
                                        .getIncomingList[index].pk
                                        .toString(),
                                    vehicleNumber: incomingController
                                            .getIncomingList[index]
                                            .vehicleVehicleNo ??
                                        '',
                                  ));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              height: 70,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: ColorRes.appPrimary.withOpacity(0.2),
                                border: Border.all(
                                  color: ColorRes.appPrimary,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${Strings.pk} : ${incomingController.getIncomingList[index].pk.toString() ?? ''}',
                                    style:
                                        const TextStyle(color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    '${Strings.vehicleNUmber} : ${incomingController.getIncomingList[index].vehicleVehicleNo ?? ''}',
                                    style:
                                        const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              incomingController.loader.value
                  ? const Center(child: FullScreenLoader())
                  : const SizedBox(),
            ],
          );
        }),
      ),
    );
  }
}
