import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/models/auth_model.dart';
import 'package:missing_application/models/case_model.dart';
import 'package:missing_application/screens/global/loading_stack.dart';

class AuthBlocConsumer extends StatefulWidget {
  const AuthBlocConsumer({
    super.key,
    required this.child,
    required this.loaded,
    this.idCheck,
    this.emailCheck,
    this.signup,
  });

  final Widget child;
  final Function(User, List<Case>) loaded;
  final Function(bool)? idCheck;
  final Function(String)? emailCheck;
  final Function(bool)? signup;

  @override
  State<AuthBlocConsumer> createState() => _AuthBlocConsumerState();
}

class _AuthBlocConsumerState extends State<AuthBlocConsumer> {
  @override
  Widget build(BuildContext _) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) => ModalRoute.of(context)!.isCurrent,
      listener: (_, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${state.error}')));
        }

        if (state is AuthLoaded) {
          widget.loaded(state.user, state.bookmarks);
        }

        if (state is AuthIdCheck && widget.idCheck != null) {
          widget.idCheck!(state.isUsable);
        }

        if (state is AuthEmailCheck && widget.emailCheck != null) {
          widget.emailCheck!(state.code);
        }

        if (state is AuthSignUp && widget.signup != null) {
          widget.signup!(state.isComplete);
        }
      },
      builder: (_, state) {
        return LoadingStack(
          isLoading: state is AuthLoading,
          child: widget.child,
        );
      },
    );
  }
}
