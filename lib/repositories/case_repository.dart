import 'package:missing_application/models/case_model.dart';

class CaseRepository {
  Case currentCase = Case.empty;
  List<Case> currentCaselist = [];
  double clientLocation = 0;

  Future getCaseList() async {}

  Future getCaseDetail() async {}
}
