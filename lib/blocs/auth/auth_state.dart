part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final User user;
  AuthLoaded(this.user);
}

class AuthError extends AuthState {
  final Object? error;
  AuthError(this.error);
}

class AuthIdCheck extends AuthState {
  final bool isUsable;
  AuthIdCheck(this.isUsable);
}

class AuthEmailCheck extends AuthState {
  final String code;
  AuthEmailCheck(this.code);
}
