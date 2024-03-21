import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project/utils/color_res.dart';
import 'package:new_project/utils/fonts.dart';

TextStyle subTitle = const TextStyle(
    color: ColorRes.appPrimary, fontSize: 15.8, fontFamily: Fonts.medium);

TextStyle blackSubTitle = const TextStyle(
    color: ColorRes.black, fontSize: 15.8, fontFamily: Fonts.medium);

TextStyle boldSubTitle = const TextStyle(
    color: ColorRes.black, fontSize: 15.8, fontFamily: Fonts.semiBold);

TextStyle smallText = const TextStyle(
    color: ColorRes.black, fontSize: 12, fontFamily: Fonts.semiBold);

TextStyle mediumText = const TextStyle(
    color: ColorRes.black, fontSize: 24, fontFamily: Fonts.medium);

TextStyle regularText = const TextStyle(
    color: ColorRes.black, fontSize: 15, fontFamily: Fonts.regular);

largeText({required Color color}) {
  return TextStyle(fontFamily: Fonts.semiBold, fontSize: 24, color: color);
}
