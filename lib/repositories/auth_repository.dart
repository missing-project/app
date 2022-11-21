import 'package:missing_application/models/auth_model.dart';
import 'package:missing_application/services/auth_service.dart';

class AuthEndPoint {
  static String get signIn => '/';
  static String get idCheck => '/albums/1';
  static String get emailCheck => '/albums/1';
}

class AuthRepository {
  User currentUser = User.empty;

  Future signIn() async {
    await Future.delayed(const Duration(seconds: 2));
    // 오류 테스트
    // throw Exception('authError');
    currentUser = currentUser.copywith(id: 'test_user');
  }

  Future<bool> idCheck(String id) async {
    final rsp = await AuthService.checkIdDuplicate();
    return rsp['id'] == 1;
  }

  Future<String> emailCheck(String email) async {
    final rsp = await AuthService.sendEmailAuthizationCode();
    return rsp['id'].toString();
  }
}
