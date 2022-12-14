import 'package:missing_application/config.dart';

class AuthEndpoint {
  static String idCheck = '/guest/checkid';
  static String idSearch = '/guest/searchId';
  static String emailCheck = '/guest/authmail';
  static String signup = '/guest/register';
  static String signIn = '/guest/login';
  static String bookmark = '/bookmark';
  static String remember = '/user/remember';
  static String resetPassword = '/guest/resetPassword';
  static String changePassword = '/user/changePassword';
  static String signout = '/user/signout';
}

class AuthService {
  static Future login(String id, String password) async {
    final response = await HttpConfig.post(
      AuthEndpoint.signIn,
      {
        "uid": id,
        "password": password,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future checkIdDuplicate(String id) async {
    final response = await HttpConfig.post(
      AuthEndpoint.idCheck,
      {
        "id": id,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception('Failed to check id');
    }
  }

  static Future searchIdByEmail(String email) async {
    final response = await HttpConfig.post(
      AuthEndpoint.idSearch,
      {
        'email': email,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception('Failed to search id');
    }
  }

  static Future sendEmailAuthizationCode(String email) async {
    final response = await HttpConfig.post(
      AuthEndpoint.emailCheck,
      {
        "email": email,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception('Failed to send code');
    }
  }

  static Future<bool> createUser(
      String id, String email, String password) async {
    final response = await HttpConfig.post(
      AuthEndpoint.signup,
      {
        "uid": id,
        "email": email,
        "password": password,
      },
    );
    return (response.statusCode == 200 || response.statusCode == 201);
  }

  static Future<List<dynamic>> findBookmarks() async {
    final response = await HttpConfigAuthorized.get(AuthEndpoint.bookmark);
    return response.data;
  }

  static Future createBookmark(String id) async {
    await HttpConfigAuthorized.post(
      AuthEndpoint.bookmark,
      {
        "key": id,
      },
    );
  }

  static Future deleteBookmark(String id) async {
    await HttpConfigAuthorized.delete(
      AuthEndpoint.bookmark,
      {
        "key": id,
      },
    );
  }

  static Future loginRemember() async {
    final response =
        await HttpConfigAuthorized.getAccessToken(AuthEndpoint.remember);
    return response.data;
  }

  static Future changeUserInfo(Map<String, dynamic> userInfo) async {
    await HttpConfig.post(AuthEndpoint.changePassword, userInfo);
  }

  static Future resetPassword(String uid, String email) async {
    await HttpConfig.post(
      AuthEndpoint.resetPassword,
      {
        "uid": uid,
        "email": email,
      },
    );
  }

  static Future changePassword(String prev, String curr) async {
    await HttpConfigAuthorized.post(
      AuthEndpoint.changePassword,
      {
        "prevPassword": prev,
        "currPassword": curr,
      },
    );
  }

  static Future deleteMe() async {
    await HttpConfigAuthorized.delete(AuthEndpoint.signout, {});
  }
}
