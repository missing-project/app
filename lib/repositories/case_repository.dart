import 'package:missing_application/models/case_model.dart';
import 'package:missing_application/services/case_service.dart';

class CaseRepository {
  Case currentCase = Case.empty;
  List<Case> currentCaselist = [];
  double clientLocation = 0;

  Future getCaseList() async {
    final response = await CaseService.getCaseList();
    // currentCaselist = response.map((el) => Case.fromJson(el)).toList();
    currentCaselist = response;
  }

  Future getCaseDetail(String id) async {
    final response = await CaseService.getCaseDetail(id);
    currentCase = Case.fromJson(response);
  }
}
