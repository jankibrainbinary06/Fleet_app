import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/common/widgets/toasts.dart';
import 'package:new_project/models/vehical/save_vehical_model.dart';
import 'package:new_project/screens/search_result_screen/search_result_screen.dart';
import 'package:new_project/screens/search_screen/search_screen.dart';
import 'package:new_project/services/http_service.dart';
import 'package:new_project/services/pref_service.dart';
import 'package:new_project/utils/endpoints.dart';
import 'package:new_project/utils/pref_keys.dart';

class VehicalApi {
  static Future saveVehicalApi({
    required Map<String, String> body,
    required String orgId,
  }) async {
    try {
      String url = Endpoints.saveVehical;
      String token = PrefService.getString(PrefKeys.token);
      // var header = {'Authorization': 'Bearer $token'};
      // http.Response? response = await HttpService.postMultipart(
      //     url: url,
      //     fields: body,
      //     imagesBase64: imagebase64,
      //     extensionType: imageExtensionList,
      //     headers: header);
      // if (response != null && response.statusCode == 200) {
      //   return saveVehicalModelFromJson(response.body);
      // } else {
      //   debugPrint('Something went wrong');
      //   return null;
      // }
      var header = {'Authorization': 'Bearer $token'};
      http.Response? response =
          await HttpService.postApi(url: url, header: header, body: body);
      if (response != null && response.statusCode == 200) {
        showToast('Vehicle Created!');
        Get.off(() => SearchResultScreen(
          orgId: orgId,
            id: saveVehicalModelFromJson(response.body)
                    .vehicleData
                    ?.pk
                    .toString() ??
                '',
            vehicleNumber: body['vehicle_no']!));
        return saveVehicalModelFromJson(response.body);
      } else {
        errorToast('Something went wrong');
        debugPrint('Something went wrong');
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
