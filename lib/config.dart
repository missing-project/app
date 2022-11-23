import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpConfig {
  static String serverUrl = 'https://jsonplaceholder.typicode.com';

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

class HttpConfigAuthority extends HttpConfig {
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
      headers: {'Authrization': token},
    );
    return result;
  }

  static Future<http.Response> post(String endpoint, Object body) async {
    final token = await _getToken();
    final result = await http.post(
      Uri.parse('${HttpConfig.serverUrl}$endpoint'),
      headers: {'Authrization': token},
      body: body,
    );
    return result;
  }

  static Future<http.Response> patch(String endpoint, Object body) async {
    final token = await _getToken();
    final result = await http.patch(
      Uri.parse('${HttpConfig.serverUrl}$endpoint'),
      headers: {'Authrization': token},
      body: body,
    );
    return result;
  }

  static Future<http.Response> delete(String endpoint, Object body) async {
    final token = await _getToken();
    final result = await http.delete(
      Uri.parse('${HttpConfig.serverUrl}$endpoint'),
      headers: {'Authrization': token},
      body: body,
    );
    return result;
  }
}
