import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:new_project/models/login_model.dart';
import 'package:new_project/screens/dash_board/dash_board_screen.dart';
import 'package:new_project/services/pref_service.dart';
import 'package:new_project/utils/color_res.dart';
import 'package:new_project/utils/endpoints.dart';
import 'package:new_project/utils/pref_keys.dart';
import 'package:new_project/utils/string_res.dart';

class LoginApi {
  static loginApi(String mobile, String passWord) async {
    try {
      String url = Endpoints.login;
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll({'mobile_no': mobile, 'password': passWord});

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();

        Get.to(() => DashBoardScreen());
        PrefService.setValue(
            PrefKeys.token, loginModelFromJson(data).token ?? '');
        PrefService.setValue(PrefKeys.isLogin, true);

        return loginModelFromJson(data);
      } else {
        Get.snackbar(Strings.invalid, Strings.userNotFound,
            colorText: ColorRes.white, backgroundColor: Colors.red);
        print(response.reasonPhrase);
      }
    } catch (e) {
      debugPrint("Something went wrong!!");
    }
  }
}
