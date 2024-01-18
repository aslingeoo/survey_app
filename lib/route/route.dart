import 'package:get/get.dart';
import 'package:survey_app_acs/pages/login.dart';
import 'package:survey_app_acs/pages/splash.dart';
import 'package:survey_app_acs/pages/survey.dart';
import 'package:survey_app_acs/pages/welcome.dart';
import 'package:survey_kit/survey_kit.dart';

class AppPages {
  AppPages._();

  static const initial = "/splash";

  static final route = [
    GetPage(
      name: "/splash",
      page: () => const SplashView(),
    ),
    GetPage(
      name: "/login",
      page: () => LoginPage(),
    ),
    GetPage(
      name: "/welcome",
      page: () => WelcomeScreen(),
    ),
     GetPage(
      name: "/survey",
      page: () => SurveyView(),
    ),
  ];
}
