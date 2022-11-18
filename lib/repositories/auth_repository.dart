import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:missing_application/models/auth_model.dart';

class AuthRepository {
  User currentUser = User.empty;

  Future signIn() async {
    await Future.delayed(const Duration(seconds: 2));
    // 오류 테스트
    // throw Exception('authError');
    currentUser = currentUser.copywith(id: 'test_user');
  }

  Future<bool> idCheck(String id) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final rsp = jsonDecode(response.body);
      return rsp['id'] == 1;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
