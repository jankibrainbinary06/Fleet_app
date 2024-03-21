import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project/screens/search_result_screen/search_result_screen.dart';

import 'package:new_project/screens/splash_screen/splash_screen.dart';
import 'package:new_project/services/pref_service.dart';
import 'package:new_project/utils/color_res.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Fleet App',
        theme: ThemeData(
          primaryColor: ColorRes.appPrimary,
          colorScheme: const ColorScheme.dark().copyWith(
            primary: ColorRes.appPrimary,
            secondary: ColorRes.appPrimary,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen()
    );
  }
}
