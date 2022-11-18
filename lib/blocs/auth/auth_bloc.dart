import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:missing_application/models/auth_model.dart';
import 'package:missing_application/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<AuthEvent>(_onLoading);
    on<Login>(_onLogin);
    on<IdCheck>(_idCheck);
    on<EmailCheck>(_emailCheck);
  }

  void _onLoading(AuthEvent event, Emitter<AuthState> emit) =>
      emit(AuthLoading());

  Future<void> _onLogin(Login event, Emitter<AuthState> emit) async {
    try {
      await repository.signIn();
      return emit(AuthLoaded(repository.currentUser));
    } catch (err) {
      return emit(AuthError(err));
    }
  }

  Future<void> _idCheck(IdCheck event, Emitter<AuthState> emit) async {
    try {
      final isUsable = await repository.idCheck(event.id);
      return emit(AuthIdCheck(isUsable));
    } catch (err) {
      return emit(AuthError(err));
    }
  }

  Future<void> _emailCheck(EmailCheck event, Emitter<AuthState> emit) async {
    try {
      final code = await repository.emailCheck(event.email);
      return emit(AuthEmailCheck(code));
    } catch (err) {
      return emit(AuthError(err));
    }
  }
}
