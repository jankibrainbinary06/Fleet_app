import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/common/widgets/toasts.dart';
import 'package:new_project/models/create_transaction_model.dart';
import 'package:new_project/models/marked_verified_model.dart';
import 'package:new_project/models/update_transaction_model.dart';

import 'package:new_project/services/http_service.dart';
import 'package:new_project/services/pref_service.dart';
import 'package:new_project/utils/endpoints.dart';
import 'package:new_project/utils/pref_keys.dart';

class CompleteTransactionApi {
  static Future completeTransactionApi(String id,) async {
    try {
      String url = '${Endpoints.completeTransaction}$id/';
      String token = PrefService.getString(PrefKeys.token);
      var header = {'Authorization': 'Bearer $token'};
      http.Response? response =
      await HttpService.postApi(url: url, header: header,);
      if (response != null && response.statusCode == 200) {
        print('mark id ===> $id');
        showToast(jsonDecode(response.body)['Message']);
return true;
      } else {
        debugPrint('Something went wrong');
        return false;

      }
    } catch (e) {
      return false;
    }
  }
}
