import 'package:http/http.dart' as http;

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
