import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class IdPwSearchScreen extends StatefulWidget {
  const IdPwSearchScreen({Key? key}) : super(key: key);

  @override
  State<IdPwSearchScreen> createState() => _IdPwSearchScreenState();
}

class _IdPwSearchScreenState extends State<IdPwSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('idpw'),
      ),
    );
  }
}
