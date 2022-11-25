import 'dart:convert';
import 'package:missing_application/config.dart';
// import 'package:missing_application/models/case_model.dart';

class CaseService {
  static String caseList = '/mp';
  static String caseDetail = '/detail';

  static Future<List<dynamic>> getCaseList() async {
    final response = await HttpConfig.get(caseList);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    }
    // static Future<List<Case>> getCaseList() async {
    // Case init = Case.empty;
    // return [
    //   init.copywith(
    //     id: '1',
    //     latitude: 37.48543063634536,
    //     longitude: 127.01553449034692,
    //     image:
    //         'https://www.safe182.go.kr/api/lcm/imgView.do?msspsnIdntfccd=5470099',
    //   ),
    //   init.copywith(
    //     id: '2',
    //     latitude: 37.51457356401562,
    //     longitude: 127.02394556254148,
    //     image:
    //         'https://www.safe182.go.kr/api/lcm/imgView.do?msspsnIdntfccd=5469965',
    //   ),
    //   init.copywith(
    //     id: '3',
    //     latitude: 37.51557402551409,
    //     longitude: 127.0490077883005,
    //     image:
    //         'https://www.safe182.go.kr/api/lcm/imgView.do?msspsnIdntfccd=5469787',
    //   ),
    //   init.copywith(
    //     id: '4',
    //     latitude: 37.49950651347085,
    //     longitude: 127.03916709870101,
    //     image:
    //         'https://www.safe182.go.kr/api/lcm/imgView.do?msspsnIdntfccd=5469612',
    //   ),
    //   init.copywith(
    //     id: '5',
    //     latitude: 37.481616261466264,
    //     longitude: 127.04042471945286,
    //     image:
    //         'https://www.safe182.go.kr/api/lcm/imgView.do?msspsnIdntfccd=5468808',
    //   ),
    // ];
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
