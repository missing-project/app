import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:missing_application/models/auth_model.dart';
import 'package:missing_application/models/case_model.dart';
import 'package:missing_application/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<AuthEvent>(_onLoading);
    on<Login>(_onLogin);
    on<LoginAuto>(_onLoginAuto);
    on<IdCheck>(_idCheck);
    on<IdSearchByEmail>(_idSearch);
    on<EmailCheck>(_emailCheck);
    on<Signup>(_signUp);
    on<BookMarkAdd>(_bookMarkAdd);
    on<BookMarkDel>(_bookMarkDel);
    on<Logout>(_onLogout);
    on<Signout>(_onSignout);
    on<UserInfoChange>(_onUserInfoChange);
    on<PasswordReset>(_onPasswordReset);
    on<PasswordChange>(_onPasswordChange);
  }

  void _onLoading(AuthEvent event, Emitter<AuthState> emit) =>
      emit(AuthLoading());

  Future<void> _onLogin(Login event, Emitter<AuthState> emit) async {
    try {
      await repository.signIn(event.id, event.password);
      await repository.bookmarkGet();
      return emit(AuthLoaded(repository.currentUser, repository.bookmarks));
    } on Exception catch (err) {
      return emit(AuthError(err));
    }
  }

  Future<void> _onLoginAuto(LoginAuto event, Emitter<AuthState> emit) async {
    try {
      final isSuccess = await repository.signInAuto();
      await repository.bookmarkGet();
      if (isSuccess) {
        return emit(AuthLoaded(repository.currentUser, repository.bookmarks));
      } else {
        return emit(AuthInitial());
      }
    } catch (err) {
      return emit(AuthInitial());
    }
  }

  Future<void> _idCheck(IdCheck event, Emitter<AuthState> emit) async {
    try {
      final isUsable = await repository.idCheck(event.id);
      return emit(AuthIdCheck(isUsable));
    } on Exception catch (err) {
      return emit(AuthError(err));
    }
  }

  Future<void> _idSearch(IdSearchByEmail event, Emitter<AuthState> emit) async {
    try {
      final uid = await repository.idSearch(event.email);
      await Future.delayed(const Duration(seconds: 2));
      return emit(AuthIdSearch(uid ?? ''));
    } on Exception catch (err) {
      return emit(AuthError(err));
    }
  }

  Future<void> _emailCheck(EmailCheck event, Emitter<AuthState> emit) async {
    try {
      final code = await repository.emailCheck(event.email);
      return emit(AuthEmailCheck(code));
    } on Exception catch (err) {
      return emit(AuthError(err));
    }
  }

  Future<void> _signUp(Signup event, Emitter<AuthState> emit) async {
    try {
      await repository.signUp(event.id, event.email, event.password);
      return emit(AuthInitial());
    } on Exception catch (err) {
      return emit(AuthError(err));
    }
  }

  Future<void> _bookMarkAdd(BookMarkAdd event, Emitter<AuthState> emit) async {
    try {
      await repository.bookMarkAdd(event.element);
      return emit(AuthLoaded(repository.currentUser, repository.bookmarks));
    } on Exception catch (err) {
      return emit(AuthError(err));
    }
  }

  Future<void> _bookMarkDel(BookMarkDel event, Emitter<AuthState> emit) async {
    try {
      await repository.bookMarkDel(event.element);
      return emit(AuthLoaded(repository.currentUser, repository.bookmarks));
    } on Exception catch (err) {
      return emit(AuthError(err));
    }
  }

  Future<void> _onLogout(Logout event, Emitter<AuthState> emit) async {
    await repository.logout();
    return emit(AuthInitial());
  }

  Future<void> _onSignout(Signout event, Emitter<AuthState> emit) async {
    try {
      await repository.signout();
      await repository.logout();
      await Future.delayed(const Duration(seconds: 2));
      return emit(AuthInitial());
    } on Exception catch (err) {
      return emit(AuthError(err));
    }
  }

  Future<void> _onUserInfoChange(
      UserInfoChange event, Emitter<AuthState> emit) async {
    try {
      await repository.userInfoChange({
        'email': event.email,
        'password': event.password,
      });
      return emit(AuthInitial());
    } on Exception catch (err) {
      return emit(AuthError(err));
    }
  }

  Future<void> _onPasswordReset(
      PasswordReset event, Emitter<AuthState> emit) async {
    try {
      await repository.resetPassword(event.uid, event.email);
      await Future.delayed(const Duration(seconds: 2));
      return emit(AuthInitial());
    } on Exception catch (err) {
      return emit(AuthError(err));
    }
  }

  Future<void> _onPasswordChange(
      PasswordChange event, Emitter<AuthState> emit) async {
    try {
      await repository.changePassword(event.prev, event.curr);
      return emit(AuthLoaded(repository.currentUser, repository.bookmarks));
    } on Exception catch (err) {
      return emit(AuthError(err));
    }
  }
}
