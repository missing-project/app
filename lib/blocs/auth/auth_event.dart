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

class Signup extends AuthEvent {
  final String id;
  final String email;

  Signup({
    required this.id,
    required this.email,
  });
}

class IdCheck extends AuthEvent {
  final String id;

  IdCheck({required this.id});
}

class EmailCheck extends AuthEvent {
  final String email;

  EmailCheck({required this.email});
}
