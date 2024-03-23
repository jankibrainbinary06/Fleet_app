import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_project/common/widgets/button.dart';
import 'package:new_project/common/widgets/loader.dart';
import 'package:new_project/common/widgets/text_fields.dart';
import 'package:new_project/screens/Auth/login/login_controller.dart';
import 'package:new_project/utils/color_res.dart';
import 'package:new_project/utils/fonts.dart';
import 'package:new_project/utils/string_res.dart';
import 'package:new_project/utils/text_styles.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ColorRes.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorRes.white,
        body: Obx(() {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox(
                        height: height * 0.1,
                        width: width,
                      ),

                      Image.asset('assets/images/logo.png',height : 200, width: Get.width,fit: BoxFit.fill,),

                      SizedBox(
                        height: height * 0.005,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.015),
                        child: Text(
                          Strings.logIn,
                          style: largeText(color: ColorRes.black),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      CommonTextField(
                          controller: controller.mobileNoController,
                          hintText: Strings.mobileNo,
                          inputType: TextInputType.number),
                      SizedBox(
                        height: height * 0.018,
                      ),
                      Obx(
                        () => CommonTextField(
                          controller: controller.passwordController,
                          hintText: Strings.password,
                          isVisible: controller.isVisible.value,
                          isSuffixIcon: true,
                          onSuffixTap: () {
                            controller.changeVisiblity();
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      CommonButton(
                        width: width,
                        text: Strings.logIn,
                        onTap: () {
                          controller.validateForm(context);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        Strings.forgotYourPassword,
                        style: TextStyle(
                            color: ColorRes.appPrimary,
                            fontSize: 17,
                            fontFamily: Fonts.semiBold),
                      ),
                    ],
                  ),
                ),
              ),
              controller.isLoading.value
                  ? const Center(
                      child: FullScreenLoader(enableBgColor: true),
                    )
                  : const SizedBox()
            ],
          );
        }),
      ),
    );
  }
}
