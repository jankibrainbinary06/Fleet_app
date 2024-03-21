import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/models/create_transaction_model.dart';
import 'package:new_project/models/search_model.dart';
import 'package:new_project/services/http_service.dart';
import 'package:new_project/services/pref_service.dart';
import 'package:new_project/utils/endpoints.dart';
import 'package:new_project/utils/pref_keys.dart';

class CreateTransactionApi {
  static Future createTransactionApi(String id,String orgId) async {
    try {
      String url = '${Endpoints.createTransaction}$id/';
      String token = PrefService.getString(PrefKeys.token);
      var header = {'Authorization': 'Bearer $token'};
      http.Response? response =
          await HttpService.postApi(url: url, header: header,body: {
            "org":orgId.toString()
          });
      if (response != null && response.statusCode == 200) {
        return createTransactionModelFromJson(response.body);
      } else {
        debugPrint('Something went wrong');
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
