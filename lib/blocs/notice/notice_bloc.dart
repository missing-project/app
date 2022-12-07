import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:missing_application/models/notice_model.dart';
import 'package:missing_application/repositories/guest_repository.dart';

part 'notice_event.dart';
part 'notice_state.dart';

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  final NoticeRepository repository;
  NoticeBloc(this.repository) : super(NoticeInit()) {
    on<NoticeEvent>(_onLoading);
    on<GetNotice>(_getNoticeList);
  }

  void _onLoading(NoticeEvent event, Emitter<NoticeState> emit) =>
      emit(NoticeLoading());

  Future<void> _getNoticeList(
      GetNotice event, Emitter<NoticeState> emit) async {
    try {
      if (repository.noticeList.isEmpty) {
        await repository.getNoticeList();
      }
      return emit(NoticeLoaded(repository.noticeList));
    } on Exception catch (err) {
      return emit(NoticeError(err));
    }
  }
}
