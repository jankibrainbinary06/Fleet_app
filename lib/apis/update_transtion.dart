import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/models/create_transaction_model.dart';
import 'package:new_project/models/update_transaction_model.dart';

import 'package:new_project/services/http_service.dart';
import 'package:new_project/services/pref_service.dart';
import 'package:new_project/utils/endpoints.dart';
import 'package:new_project/utils/pref_keys.dart';

class UpdateTransactionApi {
  static Future updateTransactionApi(String id, Map body) async {
    try {
      String url = '${Endpoints.updateTransaction}$id/';
      String token = PrefService.getString(PrefKeys.token);
      var header = {'Authorization': 'Bearer $token'};
      http.Response? response =
          await HttpService.postApi(url: url, header: header, body: body);
      if (response != null && response.statusCode == 200) {
        print('updateId ===> $id');
        return updateTransactionModelFromJson(response.body);
      } else {
        debugPrint('Something went wrong');
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
