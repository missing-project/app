import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:missing_application/routes.dart';
import 'package:missing_application/screens/auth/widgets/auth_bloc_consumer.dart';
import 'package:missing_application/screens/global/global_appbar.dart';
import 'package:missing_application/screens/global/logo_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String id = '';
  String password = '';

  void _handleLoginBtn() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(Login(id: id, password: password));
    }
  }

  Widget child(AuthState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: LogoText(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                obscureText: false,
                onChanged: ((value) {
                  setState(() {
                    id = value;
                  });
                }),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)!.id,
                ),
                validator: (value) {
                  return value == null || value.isEmpty
                      ? AppLocalizations.of(context)!.login_input_valid
                      : null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)!.password,
                ),
                validator: (value) {
                  return value == null || value.isEmpty
                      ? AppLocalizations.of(context)!.login_password_valid
                      : null;
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state is AuthLoading ? null : _handleLoginBtn,
                child: Text(
                  AppLocalizations.of(context)!.login_button,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.idpwSearch);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.login_authInquiry,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.signup);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.login_signup,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(),
      body: AuthBlocConsumer(
        loaded: (_, __) {
          Navigator.pop(context);
        },
        child: child,
      ),
    );
  }
}
