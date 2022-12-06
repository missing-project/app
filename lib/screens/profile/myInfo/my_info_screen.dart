import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/models/auth_model.dart';
import 'package:missing_application/routes.dart';
import 'package:missing_application/screens/auth/widgets/auth_bloc_consumer.dart';
import 'package:missing_application/screens/global/global_appbar.dart';

class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({Key? key}) : super(key: key);

  @override
  State<MyInfoScreen> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  String email = '';

  void handleLoaded(User user, _) {
    setState(() {
      email = user.email;
    });
  }

  void handleLogout() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('로그아웃 하시겠습니까?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('취소')),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(Logout());
                    Navigator.pop(context);
                  },
                  child: Text('확인')),
            ],
          );
        });
  }

  void handleInitial() {
    Navigator.popUntil(context, ModalRoute.withName(Routes.landing));
  }

  Widget child(AuthState state) {
    return Scaffold(
      appBar: GlobalAppbar(),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text('가입 이메일: $email'),
            ElevatedButton(onPressed: handleLogout, child: Text('로그아웃')),
            ElevatedButton(onPressed: () {}, child: Text('회원탈퇴')),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthBlocConsumer(
      loaded: handleLoaded,
      initial: handleInitial,
      child: child,
    );
  }
}
