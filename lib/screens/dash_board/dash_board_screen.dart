import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_project/common/widgets/button.dart';
import 'package:new_project/common/widgets/new_appbar.dart';
import 'package:new_project/screens/incoming_screen/incoming_screen.dart';
import 'package:new_project/screens/search_screen/search_screen.dart';
import 'package:new_project/utils/asset_res.dart';
import 'package:new_project/utils/color_res.dart';
import 'package:new_project/utils/string_res.dart';
import 'package:new_project/utils/text_styles.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorRes.white,
        body: Container(
          height: Get.height,
          width: Get.width,
          color: ColorRes.appPrimary.withOpacity(0.2),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetRes.truck,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => IncomingScreen());
                  },
                  child: Container(
                    height: 55,
                    width: Get.width * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorRes.appPrimary),
                      color: ColorRes.appPrimary,
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                    child: Text(
                      Strings.incoming,
                      style:
                          subTitle.copyWith(color: ColorRes.white, fontSize: 19),
                    ),
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Or',
                  style:
                      subTitle.copyWith(color: Color(0xff395d3b), fontSize: 22),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => SearchScreen());
                  },
                  child: Container(
                    height: 55,
                    width: Get.width * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorRes.appPrimary),
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      Strings.outGoing,
                      style: subTitle.copyWith(
                          color: ColorRes.appPrimary, fontSize: 19),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
