import 'package:missing_application/models/appinfo_model.dart';
import 'package:missing_application/models/notice_model.dart';
import 'package:missing_application/services/guest_service.dart';

class NoticeRepository {
  List<Notice> noticeList = [];

  Future getNoticeList() async {
    final response = await GuestService.getNotice();
    noticeList = response.map((el) => Notice.fromJson(el)).toList();
  }
}

class AppinfoRepository {
  Appinfo info = Appinfo.empty;

  Future getAppinfo() async {
    final response = await GuestService.getAppinfo();
    info = Appinfo.fromJson(response);
  }
}
