import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:survey_app_acs/dao/hiveHelper.dart';
import 'package:survey_app_acs/route/route.dart';

void main() {
  HiveHelper.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Survey Acs",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.route,
      theme: ThemeData(
        primaryColor: Colors.white,
        primaryColorDark: Colors.black,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        cardColor: const Color(0xFFf2f2f7),
        // textTheme: TextTheme(
        //   displayLarge: TextStyle(
        //       fontSize: Platform.isIOS ? 24 : 22,
        //       color: Colors.black,
        //       fontWeight: FontWeight.w900),
        //   titleMedium: TextStyle(
        //       fontSize: Platform.isIOS ? 20 : 18,
        //       color: Colors.black,
        //       fontWeight: FontWeight.bold),
        //   titleSmall: TextStyle(
        //     fontSize: Platform.isIOS ? 18 : 16,
        //     color: Colors.black,
        //   ),
        // ),
      ),
    );
  }
}
