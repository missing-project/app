import 'dart:convert';
import 'package:missing_application/config.dart';

class AuthService {
  static String signIn = '/albums/1';
  static String idCheck = '/albums/1';
  static String emailCheck = '/albums/2';
  static String signup = '/albums/2';

  static Future login(String id, String password) async {
    final response =
        await HttpConfig.post(signIn, {id: id, password: password});
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future checkIdDuplicate(String id) async {
    final response = await HttpConfig.post(idCheck, {id: id});
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to check id');
    }
  }

  static Future sendEmailAuthizationCode(String email) async {
    final response = await HttpConfig.post(emailCheck, {email: email});
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send code');
    }
  }

  static Future<bool> createUser(String id, String email) async {
    final response = await HttpConfig.post(signup, {id: id, email: email});
    return (response.statusCode == 200 || response.statusCode == 201);
  }
}
