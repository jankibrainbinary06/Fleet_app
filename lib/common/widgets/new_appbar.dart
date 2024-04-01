import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project/utils/color_res.dart';
import 'package:new_project/utils/text_styles.dart';

class NewAppBar extends StatelessWidget {
  const NewAppBar({
    super.key,
    required this.text1,
    required this.text2,
    required this.title,
    required this.ontap1,
    required this.ontap2,
    this.titleSize,
  });
  final String text1;
  final String text2;
  final String title;
  final double? titleSize;
  final VoidCallback ontap1;
  final VoidCallback ontap2;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: ColorRes.appPrimary,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30))),
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: ontap1,
              child: SizedBox(
                width: Get.width * 0.22,
                child: Text(
                  text1,
                  textAlign: TextAlign.start,
                  style: subTitle.copyWith(color: Colors.white),
                ),
              ),
            ),
            Text(
              title,
              style: largeText(color: ColorRes.white),
            ),
            GestureDetector(
              onTap: ontap2,
              child: SizedBox(
                width: Get.width * 0.18,
                child: Text(
                  text2,
                  textAlign: TextAlign.end,
                  style: subTitle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
