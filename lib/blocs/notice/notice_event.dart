part of 'notice_bloc.dart';

abstract class NoticeEvent extends Equatable {
  const NoticeEvent();

  @override
  List<Object> get props => [];
}

class GetNotice extends NoticeEvent {}
