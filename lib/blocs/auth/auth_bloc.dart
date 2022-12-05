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
    on<EmailCheck>(_emailCheck);
    on<Signup>(_signUp);
    on<GetUser>(_getMe);
    on<BookMarkAdd>(_bookMarkAdd);
    on<BookMarkDel>(_bookMarkDel);
    on<Logout>(_onLogout);
    on<Signout>(_onSignout);
  }

  void _onLoading(AuthEvent event, Emitter<AuthState> emit) =>
      emit(AuthLoading());

  Future<void> _onLogin(Login event, Emitter<AuthState> emit) async {
    try {
      await repository.signIn(event.id, event.password);
      await repository.bookmarkGet();
      return emit(AuthLoaded(repository.currentUser, repository.bookmarks));
    } catch (err) {
      return emit(AuthError(err));
    }
  }

  Future<void> _onLoginAuto(LoginAuto event, Emitter<AuthState> emit) async {
    try {
      final isSuccess = await repository.signInAuto();
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

  Future<void> _signUp(Signup event, Emitter<AuthState> emit) async {
    try {
      final isSuccess =
          await repository.signUp(event.id, event.email, event.password);
      return emit(AuthSignUp(isSuccess));
    } catch (err) {
      return emit(AuthError(err));
    }
  }

  Future<void> _getMe(GetUser event, Emitter<AuthState> emit) async {
    if (repository.currentUser.email.isNotEmpty) {
      return emit(AuthLoaded(repository.currentUser, repository.bookmarks));
    } else {
      return emit(AuthInitial());
    }
  }

  // 에러핸들링 추가 요망
  Future<void> _bookMarkAdd(BookMarkAdd event, Emitter<AuthState> emit) async {
    await repository.bookMarkAdd(event.element);
    return emit(AuthLoaded(repository.currentUser, repository.bookmarks));
  }

  Future<void> _bookMarkDel(BookMarkDel event, Emitter<AuthState> emit) async {
    await repository.bookMarkDel(event.element);
    return emit(AuthLoaded(repository.currentUser, repository.bookmarks));
  }

  Future<void> _onLogout(Logout event, Emitter<AuthState> emit) async {
    await repository.logout();
    return emit(AuthInitial());
  }

  Future<void> _onSignout(Signout event, Emitter<AuthState> emit) async {}
}
