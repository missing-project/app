import 'package:flutter/material.dart';
import 'package:missing_application/screens/auth/idpwSearch/idpw_search_screen.dart';
import 'package:missing_application/screens/auth/signup/signup_screen.dart';
import 'package:missing_application/screens/case/detail/case_detail_screen.dart';
import 'package:missing_application/screens/landing/landing_screen.dart';
import 'package:missing_application/screens/auth/login/login_screen.dart';
import 'package:missing_application/screens/profile/inquiry/inquiry_screen.dart';
import 'package:missing_application/screens/profile/myInfo/my_info_screen.dart';
import 'package:missing_application/screens/profile/notice/notice_screen.dart';

class Routes {
  static String get landing => '/';
  static String get login => '/login';
  static String get signup => '/signup';
  static String get caseDetail => '/caseDetail';
  static String get idpwSearch => '/idpwSearch';
  static String get myInfo => '/myInfo';
  static String get inquiry => '/inquiry';
  static String get setting => '/setting';
  static String get notice => '/notice';
}

final routes = {
  Routes.landing: (BuildContext context) => LandingScreen(),
  Routes.login: (BuildContext context) => LoginScreen(),
  Routes.signup: (BuildContext context) => SignUpScreen(),
  Routes.caseDetail: (BuildContext context) => CaseDetailScreen(),
  Routes.idpwSearch: (BuildContext context) => IdPwSearchScreen(),
  Routes.myInfo: (BuildContext context) => MyInfoScreen(),
  Routes.inquiry: (BuildContext context) => InquiryScreen(),
  Routes.notice: (BuildContext context) => NoticeScreen(),
};
