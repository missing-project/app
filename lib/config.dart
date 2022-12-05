import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpConfig {
  // static String serverUrl = 'https://jsonplaceholder.typicode.com';
  static String serverUrl = 'http://10.0.2.2:8989'; // android
  // static String serverUrl = 'http://localhost:8989'; // ios
  // static String serverUrl = 'http://13.209.238.196:8989'; // aws

  static Future<http.Response> get(String endpoint) async {
    final result = await http.get(Uri.parse('$serverUrl$endpoint'));
    return result;
  }

  static Future<http.Response> post(String endpoint, Object body) async {
    final result =
        await http.post(Uri.parse('$serverUrl$endpoint'), body: body);
    return result;
  }

  static Future<http.Response> patch(String endpoint, Object body) async {
    final result =
        await http.patch(Uri.parse('$serverUrl$endpoint'), body: body);
    return result;
  }

  static Future<http.Response> delete(String endpoint, Object body) async {
    final result =
        await http.delete(Uri.parse('$serverUrl$endpoint'), body: body);
    return result;
  }
}

class HttpConfigAuthorized {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<String> _getToken() async {
    final SharedPreferences pref = await _prefs;
    final token = pref.getString('token') ?? '';
    if (token.isEmpty) {
      throw Exception('no Authrization');
    }
    return token;
  }

  static Future<http.Response> get(String endpoint) async {
    final token = await _getToken();
    final result = await http.get(
      Uri.parse('${HttpConfig.serverUrl}$endpoint'),
      headers: {'authorization': 'access $token'},
    );
    return result;
  }

  static Future<http.Response> post(String endpoint, Object body) async {
    final token = await _getToken();
    final result = await http.post(
      Uri.parse('${HttpConfig.serverUrl}$endpoint'),
      headers: {'authorization': 'access $token'},
      body: body,
    );
    return result;
  }

  static Future<http.Response> patch(String endpoint, Object body) async {
    final token = await _getToken();
    final result = await http.patch(
      Uri.parse('${HttpConfig.serverUrl}$endpoint'),
      headers: {'authorization': 'access $token'},
      body: body,
    );
    return result;
  }

  static Future<http.Response> delete(String endpoint, Object body) async {
    final token = await _getToken();
    final result = await http.delete(
      Uri.parse('${HttpConfig.serverUrl}$endpoint'),
      headers: {'authorization': 'access $token'},
      body: body,
    );
    return result;
  }
}
