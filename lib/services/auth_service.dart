import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:missing_application/config.dart';

class AuthService {
  static String signIn = '/';
  static String idCheck = '/albums/1';
  static String emailCheck = '/albums/2';

  static Future checkIdDuplicate() async {
    final response = await http.get(Uri.parse('${Config.serverUrl}$idCheck'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future sendEmailAuthizationCode() async {
    final response =
        await http.get(Uri.parse('${Config.serverUrl}$emailCheck'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }
}
