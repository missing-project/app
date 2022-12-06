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
  final List<Case> bookmarks;
  AuthLoaded(this.user, this.bookmarks);
}

class AuthError extends AuthState {
  final Exception error;
  AuthError(this.error);
}

class AuthIdCheck extends AuthState {
  final bool isUsable;
  AuthIdCheck(this.isUsable);
}

class AuthIdSearch extends AuthState {
  final String uid;
  AuthIdSearch(this.uid);
}

class AuthEmailCheck extends AuthState {
  final String code;
  AuthEmailCheck(this.code);
}

class AuthSignUp extends AuthState {
  final bool isComplete;
  AuthSignUp(this.isComplete);
}
