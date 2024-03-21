import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project/utils/color_res.dart';

void errorToast(String error, {String? title}) {
  Get.snackbar(
    title ?? "Error",
    error,
    duration: const Duration(milliseconds: 1500),
    colorText: ColorRes.white,
    backgroundColor: Colors.red,
  );
}

void showToast(String value, {String? title}) {
  Get.snackbar(
    title ?? "Success",
    value,
    duration: const Duration(milliseconds: 1500),
    colorText: ColorRes.white,
    backgroundColor: Colors.green,
  );
}
