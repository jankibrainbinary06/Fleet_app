import 'package:flutter/material.dart';
import 'package:new_project/models/get_all_transporters_model.dart';
import 'package:new_project/services/http_service.dart';
import 'package:new_project/services/pref_service.dart';
import 'package:new_project/utils/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/utils/pref_keys.dart';

class GetAllTraApi {
  static Future getAllTragApi() async {
    try {
      String url = Endpoints.getAllTransporters;
      String token = PrefService.getString(PrefKeys.token);
      var header = {'Authorization': 'Bearer $token'};
      http.Response? response =
      await HttpService.getApi(url: url, header: header);
      if (response != null && response.statusCode == 200) {
        return getTransporterModelFromJson(response.body);
      } else {
        debugPrint('Something went wrong');
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}