import 'package:get/get.dart';
import 'package:new_project/screens/Auth/login/login_screen.dart';
import 'package:new_project/screens/dash_board/dash_board_screen.dart';
import 'package:new_project/services/pref_service.dart';
import 'package:new_project/utils/pref_keys.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        return PrefService.getBool(PrefKeys.isLogin) == true
            ? Get.offAll(() => DashBoardScreen())
            : Get.offAll(() => LoginScreen());
      },
    );
    super.onInit();
  }
}
