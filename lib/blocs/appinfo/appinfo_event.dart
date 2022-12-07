part of 'appinfo_bloc.dart';

abstract class AppinfoEvent extends Equatable {
  const AppinfoEvent();

  @override
  List<Object> get props => [];
}

class GetAppinfo extends AppinfoEvent {}
