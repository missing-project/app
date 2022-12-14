part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class Login extends AuthEvent {
  final String id;
  final String password;

  Login({required this.id, required this.password});
}

class LoginAuto extends AuthEvent {}

class Signup extends AuthEvent {
  final String id;
  final String email;
  final String password;

  Signup({
    required this.id,
    required this.email,
    required this.password,
  });
}

class IdCheck extends AuthEvent {
  final String id;

  IdCheck({required this.id});
}

class IdSearchByEmail extends AuthEvent {
  final String email;
  IdSearchByEmail({required this.email});
}

class EmailCheck extends AuthEvent {
  final String email;

  EmailCheck({required this.email});
}

class BookMarkAdd extends AuthEvent {
  final Case element;
  BookMarkAdd({required this.element});
}

class BookMarkDel extends AuthEvent {
  final Case element;
  BookMarkDel({required this.element});
}

class Logout extends AuthEvent {}

class Signout extends AuthEvent {}

class UserInfoChange extends AuthEvent {
  final String? email;
  final String? password;
  UserInfoChange({this.email, this.password});
}

class PasswordReset extends AuthEvent {
  final String uid;
  final String email;
  PasswordReset({required this.uid, required this.email});
}

class PasswordChange extends AuthEvent {
  final String prev;
  final String curr;
  PasswordChange({required this.prev, required this.curr});
}
