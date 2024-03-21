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

class MarkedVerifiedApi {
  static Future markedVerifiedApi(String id, Map body) async {
    try {
      String url = '${Endpoints.markedVerified}$id/';
      String token = PrefService.getString(PrefKeys.token);
      var header = {'Authorization': 'Bearer $token'};
      http.Response? response =
          await HttpService.postApi(url: url, header: header, body: body);
      if (response != null && response.statusCode == 200) {
        print('mark id ===> $id');

        return markedVerifiedModelFromJson(response.body);
      } else {
        debugPrint('Something went wrong');

        return markedVerifiedModelFromJson(response!.body);
      }
    } catch (e) {
      return null;
    }
  }
}
