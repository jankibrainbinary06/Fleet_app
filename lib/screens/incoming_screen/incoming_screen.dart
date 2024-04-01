import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_project/common/widgets/loader.dart';
import 'package:new_project/common/widgets/new_appbar.dart';
import 'package:new_project/global.dart';
import 'package:new_project/screens/incoming_qr_screen/incoming_qr_controller.dart';
import 'package:new_project/screens/incoming_qr_screen/incoming_qr_screen.dart';
import 'package:new_project/screens/incoming_screen/incoming_controller.dart';
import 'package:new_project/utils/color_res.dart';
import 'package:new_project/utils/string_res.dart';

class IncomingScreen extends StatelessWidget {
  IncomingScreen({Key? key}) : super(key: key);
  final IncomingController incomingController = Get.put(IncomingController());
  @override
  Widget build(BuildContext context) {
    Global().toggle();
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
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                            shrinkWrap: true,
                            itemCount: incomingController.getIncomingList.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  final IncomingQRController incomingQRController =
                                  Get.put(IncomingQRController(markedId: incomingController
                                      .getIncomingList[index].pk
                                      .toString()));
                                  incomingQRController.getTransactionApi(incomingController
                                      .getIncomingList[index].pk
                                      .toString());


                                  Get.to(() => IncomingQRScreen(
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
                                  padding: EdgeInsets.symmetric(horizontal: 10),
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
                                      SizedBox(
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
                        ],
                      ),
                    ),
                  )
                ],
              ),
              incomingController.loader.value
                  ? Center(child: const FullScreenLoader())
                  : SizedBox(),
            ],
          );
        }),
      ),
    );
  }
}
