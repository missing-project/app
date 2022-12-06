import 'package:missing_application/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class HttpConfig {
  static String serverUrl = 'http://10.0.2.2:8989'; // android
  // static String serverUrl = 'http://localhost:8989'; // ios
  // static String serverUrl = 'http://13.209.238.196:8989'; // aws

  static final Dio _dioUnauthorized = Dio(
    BaseOptions(
      baseUrl: serverUrl,
    ),
  );

  static Future<Response> get(String endpoint) async {
    final result = await _dioUnauthorized.get(endpoint);
    return result;
  }

  static Future<Response> post(String endpoint, Object body) async {
    final result = await _dioUnauthorized.post(endpoint, data: body);
    return result;
  }

  static Future<Response> patch(String endpoint, Object body) async {
    final result = await _dioUnauthorized.patch(endpoint, data: body);
    return result;
  }

  static Future<Response> delete(String endpoint, Object body) async {
    final result = await _dioUnauthorized.delete(endpoint, data: body);
    return result;
  }
}

class HttpConfigAuthorized {
  static Future<SharedPreferences> _prefs() async {
    return await SharedPreferences.getInstance();
  }

  static Future<String> _getToken() async {
    final SharedPreferences pref = await _prefs();
    final token = pref.getString(PreferencesKey.accesstoken) ?? '';
    if (token.isEmpty) {
      throw Exception('no Authrization');
    }
    return token;
  }

  static Future<Dio> _dioAuthorized() async {
    final token = await _getToken();
    return Dio(
      BaseOptions(
        baseUrl: HttpConfig.serverUrl,
        headers: {'authorization': 'access $token'},
      ),
    );
  }

  static Future<Response> _tokenExpireHandler(
    Future<Response> Function(String, Object) dioRequest,
    String endpoint,
    Object body,
  ) async {
    bool isExpiredToken = false;
    Response<dynamic> result = await dioRequest(endpoint, body).catchError(
      (error) {
        if (error is DioError) {
          if (error.response!.data['message'] == 'jwt expired') {
            isExpiredToken = true;
          } else {
            throw Exception(error.response!.data['message']);
          }
        }
      },
    );

    if (isExpiredToken) {
      final SharedPreferences prefs = await _prefs();
      final refreshToken = prefs.getString(PreferencesKey.refreshtoken) ?? '';
      final dioRefresh = Dio(
        BaseOptions(
          baseUrl: HttpConfig.serverUrl,
          headers: {'authorization': 'refresh $refreshToken'},
        ),
      );
      final rsp = await dioRefresh.get('/user/refresh');
      prefs.setString(PreferencesKey.accesstoken, rsp.data['accessToken']);
      prefs.setString(PreferencesKey.refreshtoken, rsp.data['refreshToken']);
      result = await dioRequest(endpoint, body);
    }

    return result;
  }

  static Future<Response> _get(String endpoint, Object body) async {
    final dio = await _dioAuthorized();
    final result = await dio.get(endpoint);
    return result;
  }

  static Future<Response> _post(String endpoint, Object body) async {
    final dio = await _dioAuthorized();
    final result = await dio.post(endpoint, data: body);
    return result;
  }

  static Future<Response> _patch(String endpoint, Object body) async {
    final dio = await _dioAuthorized();
    final result = await dio.patch(endpoint, data: body);
    return result;
  }

  static Future<Response> _delete(String endpoint, Object body) async {
    final dio = await _dioAuthorized();
    final result = await dio.delete(endpoint, data: body);
    return result;
  }

  static Future<Response> get(String endpoint, [Object body = const {}]) =>
      _tokenExpireHandler(_get, endpoint, body);

  static Future<Response> post(String endpoint, Object body) =>
      _tokenExpireHandler(_post, endpoint, body);

  static Future<Response> patch(String endpoint, Object body) =>
      _tokenExpireHandler(_patch, endpoint, body);

  static Future<Response> delete(String endpoint, Object body) =>
      _tokenExpireHandler(_delete, endpoint, body);
}
