// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_project/apis/login_api.dart';
import 'package:new_project/common/widgets/toasts.dart';
import 'package:new_project/screens/dash_board/dash_board_screen.dart';

class LoginController extends GetxController {
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isVisible = true.obs;
  RxBool isLoginScreen = true.obs;
  RxBool isLoading = false.obs;

  changeVisiblity() {
    isVisible.value = !isVisible.value;
  }

  validateForm(BuildContext context) async {
    if (mobileNoController.text.isEmpty) {
      errorToast("Mobile number can't be empty");
    } else if (passwordController.text.isEmpty) {
      errorToast("Password can't be empty");
    } else {
      await loginAPi();
    }
  }

  loginAPi() async {
    try {
      isLoading.value = true;
      await LoginApi.loginApi(mobileNoController.text, passwordController.text);
      isLoading.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
