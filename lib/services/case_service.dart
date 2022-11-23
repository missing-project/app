import 'dart:convert';
import 'package:missing_application/config.dart';

class CaseService {
  static String caseList = '/';
  static String caseDetail = '/detail';

  static Future getCaseList() async {
    final response = await HttpConfig.get(caseList);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future getCaseDetail(String id) async {
    final response = await HttpConfig.get('$caseDetail/?id=$id');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    }
  }
}
