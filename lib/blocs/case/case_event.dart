part of 'case_bloc.dart';

abstract class CaseEvent extends Equatable {
  const CaseEvent();

  @override
  List<Object> get props => [];
}

class CaseList extends CaseEvent {}

class CaseDetail extends CaseEvent {
  final String id;

  CaseDetail({required this.id});
}
