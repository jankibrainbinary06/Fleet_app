import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project/utils/color_res.dart';
import 'package:new_project/utils/fonts.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.width,
    required this.text,
    required this.onTap,
    this.color,
    this.padding,
    this.height,
  });

  final double width;
  final double? height;
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: padding ?? Get.height * 0.03),
        decoration: BoxDecoration(
            color: color ?? ColorRes.appPrimary,
            borderRadius: BorderRadius.circular(100)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 16, fontFamily: Fonts.semiBold, height: 1),
        ),
      ),
    );
  }
}
