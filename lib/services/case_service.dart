import 'dart:convert';
import 'package:missing_application/config.dart';
import 'package:missing_application/models/case_model.dart';

class CaseService {
  static String caseList = '/';
  static String caseDetail = '/detail';

  // static Future<List<Map<String, dynamic>>> getCaseList() async {
  static Future<List<Case>> getCaseList() async {
    Case init = Case.empty;
    return [
      init.copywith(id: '1', image: 'https://source.unsplash.com/mou0S7ViElQ'),
      init.copywith(id: '2', image: 'https://source.unsplash.com/t0Bv0OBQuTg'),
      init.copywith(id: '3', image: 'https://source.unsplash.com/K-sdQ12jZeY'),
      init.copywith(id: '4', image: 'https://source.unsplash.com/0rxLLHD1XxA'),
    ];
    // final response = await HttpConfig.get(caseList);
    // if (response.statusCode == 200 || response.statusCode == 201) {
    //   return jsonDecode(response.body);
    // } else {
    //   throw Exception(response.body);
    // }
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
