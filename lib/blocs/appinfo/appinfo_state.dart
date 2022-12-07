part of 'appinfo_bloc.dart';

abstract class AppinfoState extends Equatable {
  const AppinfoState();

  @override
  List<Object> get props => [];
}

class AppinfoInit extends AppinfoState {}

class AppinfoLoading extends AppinfoState {}

class AppinfoLoaded extends AppinfoState {
  final Appinfo info;
  AppinfoLoaded(this.info);
}

class AppinfoError extends AppinfoState {
  final Exception? error;
  AppinfoError(this.error);
}
