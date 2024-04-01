import 'package:get/get.dart';
import 'package:new_project/apis/get_incoming_api.dart';
import 'package:new_project/models/get_incoming.dart';

class IncomingController extends GetxController {
  @override
  void onInit() {
    getIncomingAPi();
    super.onInit();
  }

  RxBool loader = false.obs;
  List<GetIncomingModel> getIncomingList = [];
  getIncomingAPi() async {
    try {
      loader.value = true;
      getIncomingList = await GetIncomingApi.getIncomingApi();

      loader.value = false;
    } catch (e) {
      print(e.toString());
      loader.value = false;
    }
  }
}
