import 'dart:convert';
import 'package:missing_application/config.dart';

class AuthService {
  static String signIn = '/guest/login';
  static String idCheck = '/guest/checkid';
  static String emailCheck = '/guest/authmail';
  static String signup = '/guest/register';
  static String me = '/albums/2';

  static Future login(String id, String password) async {
    final response =
        await HttpConfig.post(signIn, {"uid": id, "password": password});
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future checkIdDuplicate(String id) async {
    final response = await HttpConfig.post(idCheck, {"id": id});
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to check id');
    }
  }

  static Future sendEmailAuthizationCode(String email) async {
    final response = await HttpConfig.post(emailCheck, {"email": email});
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send code');
    }
  }

  static Future<bool> createUser(
      String id, String email, String password) async {
    final response = await HttpConfig.post(
        signup, {"uid": id, "email": email, "password": password});
    return (response.statusCode == 200 || response.statusCode == 201);
  }

  static Future getMe() async {
    final response = await HttpConfigAuthority.get(me);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get ne');
    }
  }
}
