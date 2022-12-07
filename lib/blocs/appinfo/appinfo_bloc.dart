import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:missing_application/models/appinfo_model.dart';
import 'package:missing_application/repositories/guest_repository.dart';

part 'appinfo_event.dart';
part 'appinfo_state.dart';

class AppinfoBloc extends Bloc<AppinfoEvent, AppinfoState> {
  final AppinfoRepository repository;
  AppinfoBloc(this.repository) : super(AppinfoInit()) {
    on<AppinfoEvent>(_onLoading);
    on<GetAppinfo>(_getAppinfo);
  }

  void _onLoading(AppinfoEvent event, Emitter<AppinfoState> emit) =>
      emit(AppinfoLoading());

  Future<void> _getAppinfo(GetAppinfo event, Emitter<AppinfoState> emit) async {
    try {
      if (repository.info == Appinfo.empty) {
        await repository.getAppinfo();
      }
      return emit(AppinfoLoaded(repository.info));
    } on Exception catch (err) {
      return emit(AppinfoError(err));
    }
  }
}
