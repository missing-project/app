import 'package:flutter/material.dart';
import 'package:missing_application/models/auth_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return AuthBlocConsumer(
      loaded: handleLoaded,
      child: Scaffold(
        appBar: GlobalAppbar(),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text('가입 이메일: $email'),
              ElevatedButton(onPressed: () {}, child: Text('로그아웃')),
              ElevatedButton(onPressed: () {}, child: Text('회원탈퇴')),
            ],
          ),
        ),
      ),
    );
  }
}
