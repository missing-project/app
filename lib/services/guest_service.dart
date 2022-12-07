import 'package:missing_application/config.dart';

class GuestEndpoint {
  static String notice = '/guest/notice';
  static String appinfo = '/guest/appinfo';
}

class GuestService {
  static Future<List<dynamic>> getNotice() async {
    final response = await HttpConfig.get(GuestEndpoint.notice);
    return response.data;
  }

  static Future getAppinfo() async {
    final response = await HttpConfig.get(GuestEndpoint.appinfo);
    return response.data;
  }
}
