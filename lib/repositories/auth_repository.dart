import 'package:missing_application/models/auth_model.dart';

class AuthRepository {
  User currentUser = User.empty;

  Future signIn() async {
    await Future.delayed(const Duration(seconds: 2));
    // 오류 테스트
    // throw Exception('authError');
    currentUser = currentUser.copywith(id: 'test_user');
  }
}
