import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/routes.dart';
import 'package:missing_application/screens/auth/widgets/auth_bloc_consumer.dart';
import 'package:missing_application/screens/profile/myInfo/my_info_widgets.dart';

class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({Key? key}) : super(key: key);

  @override
  State<MyInfoScreen> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  void handleChangePassword() {
    showDialog(
        context: context,
        builder: (context) {
          return PasswrodChangeDialog();
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

  void handleSignout() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('회원탈퇴 하시겠습니까?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('취소')),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(Signout());
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

  void handleChangePasswordComplete(_, __) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('비밀번호가 변경되었습니다'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('확인'),
            )
          ],
        );
      },
    );
  }

  Widget child(AuthState state) {
    return Scaffold(
      appBar: AppBar(title: Text('내 정보')),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '가입 이메일: ${state is AuthLoaded ? state.user.email : ''}',
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: handleChangePassword,
                child: Text('비밀번호 변경'),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(onPressed: handleLogout, child: Text('로그아웃')),
                  TextButton(onPressed: handleSignout, child: Text('회원탈퇴')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthBlocConsumer(
      loaded: handleChangePasswordComplete,
      initial: handleInitial,
      child: child,
    );
  }
}
