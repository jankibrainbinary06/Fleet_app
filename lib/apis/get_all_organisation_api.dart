import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/models/get_all_org_model.dart';
import 'package:new_project/models/search_model.dart';
import 'package:new_project/services/http_service.dart';
import 'package:new_project/services/pref_service.dart';
import 'package:new_project/utils/endpoints.dart';
import 'package:new_project/utils/pref_keys.dart';

class GetAllOrgApi {
  static Future getAllOrgApi() async {
    try {
      String url = Endpoints.getAllOrg;
      String token = PrefService.getString(PrefKeys.token);
      var header = {'Authorization': 'Bearer $token'};
      http.Response? response =
          await HttpService.getApi(url: url, header: header);
      if (response != null && response.statusCode == 200) {
        return getAllOrgModelFromJson(response.body);
      } else {
        debugPrint('Something went wrong');
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
