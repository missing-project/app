part of 'case_bloc.dart';

abstract class CaseState extends Equatable {
  const CaseState();

  @override
  List<Object> get props => [];
}

class CaseInit extends CaseState {}

class CaseLoading extends CaseState {}

class CaseLoaded extends CaseState {
  final Case currentCase;
  final List<Case> currentCaselist;

  CaseLoaded(this.currentCase, this.currentCaselist);
}

class CaseError extends CaseState {
  final Object? error;
  CaseError(this.error);
}
