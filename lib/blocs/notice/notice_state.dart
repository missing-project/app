part of 'notice_bloc.dart';

abstract class NoticeState extends Equatable {
  const NoticeState();

  @override
  List<Object> get props => [];
}

class NoticeInit extends NoticeState {}

class NoticeLoading extends NoticeState {}

class NoticeLoaded extends NoticeState {
  final List<Notice> noticeList;
  NoticeLoaded(this.noticeList);
}

class NoticeError extends NoticeState {
  final Exception? error;
  NoticeError(this.error);
}
