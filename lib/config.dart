import 'package:missing_application/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class HttpConfig {
  // static String serverUrl = 'http://10.0.2.2:8989'; // android
  // static String serverUrl = 'http://localhost:8989'; // ios
  static String serverUrl = 'http://13.209.238.196'; // aws

  static final Dio _dioUnauthorized = Dio(
    BaseOptions(
      baseUrl: serverUrl,
    ),
  );

  static Future<Response> _catchErrorHandler(
    Future<Response> Function(String, Object) dioRequest,
    String endpoint,
    Object body,
  ) async {
    final result = await dioRequest(endpoint, body).catchError((error) {
      if (error is DioError) {
        throw Exception(error.response!.data['message']);
      }
    });
    return result;
  }

  static Future<Response> _get(String endpoint, Object body) async {
    final result = await _dioUnauthorized.get(endpoint);
    return result;
  }

  static Future<Response> _post(String endpoint, Object body) async {
    final result = await _dioUnauthorized.post(endpoint, data: body);
    return result;
  }

  static Future<Response> _patch(String endpoint, Object body) async {
    final result = await _dioUnauthorized.patch(endpoint, data: body);
    return result;
  }

  static Future<Response> _delete(String endpoint, Object body) async {
    final result = await _dioUnauthorized.delete(endpoint, data: body);
    return result;
  }

  static Future<Response> get(String endpoint, [Object body = const {}]) =>
      _catchErrorHandler(_get, endpoint, body);
  static Future<Response> post(String endpoint, [Object body = const {}]) =>
      _catchErrorHandler(_post, endpoint, body);
  static Future<Response> patch(String endpoint, [Object body = const {}]) =>
      _catchErrorHandler(_patch, endpoint, body);
  static Future<Response> delete(String endpoint, [Object body = const {}]) =>
      _catchErrorHandler(_delete, endpoint, body);
}

class HttpConfigAuthorized {
  static Future<SharedPreferences> _prefs() async {
    return await SharedPreferences.getInstance();
  }

  static Future<String> _getToken() async {
    final SharedPreferences prefs = await _prefs();
    final token = prefs.getString(PreferencesKey.accesstoken) ?? '';
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

  static Future<Response> getAccessToken(String enpoint) async {
    final SharedPreferences prefs = await _prefs();
    final refreshToken = prefs.getString(PreferencesKey.refreshtoken) ?? '';
    final dioRefresh = Dio(
      BaseOptions(
        baseUrl: HttpConfig.serverUrl,
        headers: {'authorization': 'refresh $refreshToken'},
      ),
    );
    final response = await dioRefresh.get(enpoint).catchError((err) {
      if (err is DioError) {
        throw Exception(err.response!.data['message']);
      }
    });
    prefs.setString(PreferencesKey.accesstoken, response.data['accessToken']);
    prefs.setString(PreferencesKey.refreshtoken, response.data['refreshToken']);
    return response;
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
      await getAccessToken('/user/refresh');
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
