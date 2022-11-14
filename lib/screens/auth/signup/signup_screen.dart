import 'package:flutter/material.dart';
import 'package:missing_application/screens/global/global_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:missing_application/screens/global/loading_stack.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pwFocusNode = FocusNode();
  final _pwChFocusNode = FocusNode();
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  String id = '';
  String password = '';
  String passwordCheck = '';
  String email = '';
  bool emaiAuthrization = false;
  bool termsAgreement = false;
  bool isButtonActive = false;

  String? get _errorText {
    if (_pwFocusNode.hasFocus && !regex.hasMatch(password)) {
      return '대소문자, 숫자, 특수기호를 포함하여 8자 이상이어야 합니다';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(),
      body: LoadingStack(
          isLoading: false,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      TextFormField(
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
                              ? AppLocalizations.of(context)!.signup_id_invalid
                              : null;
                        },
                      ),
                      TextFormField(
                        obscureText: false,
                        focusNode: _pwFocusNode,
                        onChanged: ((value) {
                          setState(() {
                            password = value;
                          });
                        }),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppLocalizations.of(context)!.password,
                          errorText: _errorText,
                        ),
                        validator: (value) {
                          return value == null ||
                                  value.isEmpty ||
                                  !regex.hasMatch(value)
                              ? AppLocalizations.of(context)!.signup_pw_invalid
                              : null;
                        },
                      ),
                      TextFormField(
                        obscureText: false,
                        focusNode: _pwChFocusNode,
                        onChanged: ((value) {
                          setState(() {
                            passwordCheck = value;
                          });
                        }),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText:
                              AppLocalizations.of(context)!.passwordCheck,
                          errorText: _pwChFocusNode.hasFocus &&
                                  password != passwordCheck
                              ? AppLocalizations.of(context)!
                                  .signup_pwCh_invalid
                              : null,
                        ),
                        validator: (value) {
                          return value == null ||
                                  value.isEmpty ||
                                  password != passwordCheck
                              ? AppLocalizations.of(context)!
                                  .signup_pwCh_invalid
                              : null;
                        },
                      ),
                      Checkbox(
                          value: termsAgreement,
                          onChanged: (value) {
                            setState(() {
                              termsAgreement = value!;
                            });
                          })
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed:
                        termsAgreement && _formKey.currentState!.validate()
                            ? () {}
                            : null,
                    style: TextButton.styleFrom(
                      disabledBackgroundColor: Colors.grey[100],
                      disabledForegroundColor: Colors.black,
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('회원가입'),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
