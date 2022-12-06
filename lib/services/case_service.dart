import 'package:missing_application/config.dart';
// import 'package:missing_application/models/case_model.dart';

class CaseEndpoint {
  static String caseList = '/case';
  static String caseDetail = '/detail';
}

class CaseService {
  static Future<List<dynamic>> getCaseList() async {
    final response = await HttpConfig.get(CaseEndpoint.caseList);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception(response.data);
    }
  }

  static Future getCaseDetail(String id) async {
    final response = await HttpConfig.get('${CaseEndpoint.caseDetail}/?id=$id');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception(response.data);
    }
  }
}
