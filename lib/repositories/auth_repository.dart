import 'package:missing_application/models/auth_model.dart';
import 'package:missing_application/services/auth_service.dart';

class AuthEndPoint {
  static String get signIn => '/';
  static String get idCheck => '/albums/1';
  static String get emailCheck => '/albums/1';
}

class AuthRepository {
  User currentUser = User.empty;

  Future signIn(String id, String password) async {
    final rsp = await AuthService.login(id, password);
    currentUser = User.fromJson(rsp);
  }

  Future<bool> idCheck(String id) async {
    final rsp = await AuthService.checkIdDuplicate(id);
    return rsp['id'] == 1;
  }

  Future<String> emailCheck(String email) async {
    final rsp = await AuthService.sendEmailAuthizationCode(email);
    return rsp['id'].toString();
  }

  Future<bool> signUp(String id, String email) async {
    final isSuccess = await AuthService.createUser(id, email);
    return isSuccess;
  }
}
