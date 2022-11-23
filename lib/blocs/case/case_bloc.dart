import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:missing_application/models/case_model.dart';
import 'package:missing_application/repositories/case_repository.dart';

part 'case_event.dart';
part 'case_state.dart';

class CaseBloc extends Bloc<CaseEvent, CaseState> {
  final CaseRepository repository;
  CaseBloc(this.repository) : super(CaseInit()) {
    on<CaseEvent>(_onLoading);
    on<CaseList>(_getCaseList);
    on<CaseDetail>(_getCaseDetail);
  }

  void _onLoading(CaseEvent event, Emitter<CaseState> emit) =>
      emit(CaseLoading());

  Future<void> _getCaseList(CaseList event, Emitter<CaseState> emit) async {
    try {
      await repository.getCaseList();
      return emit(
          CaseLoaded(repository.currentCase, repository.currentCaselist));
    } catch (err) {
      return emit(CaseError(err));
    }
  }

  Future<void> _getCaseDetail(CaseDetail event, Emitter<CaseState> emit) async {
    try {
      await repository.getCaseDetail();
      return emit(
          CaseLoaded(repository.currentCase, repository.currentCaselist));
    } catch (err) {
      return emit(CaseError(err));
    }
  }
}
