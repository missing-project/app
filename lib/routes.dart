import 'package:flutter/material.dart';
import 'package:missing_application/screens/auth/idpwSearch/idpw_search_screen.dart';
import 'package:missing_application/screens/auth/signup/signup_screen.dart';
import 'package:missing_application/screens/detail/case/case_detail_screen.dart';
import 'package:missing_application/screens/landing/landing_screen.dart';
import 'package:missing_application/screens/auth/login/login_screen.dart';
import 'package:missing_application/screens/profile/alarm/alarm_screen.dart';
import 'package:missing_application/screens/profile/inquiry/inquiry_screen.dart';
import 'package:missing_application/screens/profile/myInfo/my_info_screen.dart';
import 'package:missing_application/screens/profile/report/report_screen.dart';
import 'package:missing_application/screens/profile/setting/setting_screen.dart';

class Routes {
  static String get landing => '/';
  static String get login => '/login';
  static String get signup => '/signup';
  static String get caseDetail => '/caseDetail';
  static String get idpwSearch => '/idpwSearch';
  static String get myInfo => '/myInfo';
  static String get alarm => '/alarm';
  static String get inquiry => '/inquiry';
  static String get report => '/report';
  static String get setting => '/setting';
}

final routes = {
  Routes.landing: (BuildContext context) => LandingScreen(),
  Routes.login: (BuildContext context) => LoginScreen(),
  Routes.signup: (BuildContext context) => SignUpScreen(),
  Routes.caseDetail: (BuildContext context) => CaseDetailScreen(),
  Routes.idpwSearch: (BuildContext context) => IdPwSearchScreen(),
  Routes.myInfo: (BuildContext context) => MyInfoScreen(),
  Routes.alarm: (BuildContext context) => AlarmScreen(),
  Routes.inquiry: (BuildContext context) => InquiryScreen(),
  Routes.report: (BuildContext context) => ReportScreen(),
  Routes.setting: (BuildContext context) => SettingScreen(),
};
