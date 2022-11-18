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
  bool emailAuthrization = false;
  bool termsAgreement = false;

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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ListView(
                      children: [
                        SignUpPadding(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormFieldStyle(
                                  obscure: false,
                                  label: AppLocalizations.of(context)!.id,
                                  onChanged: ((value) {
                                    setState(() {
                                      id = value;
                                    });
                                  }),
                                  validator: (value) {
                                    return value == null || value.isEmpty
                                        ? AppLocalizations.of(context)!
                                            .signup_id_invalid
                                        : null;
                                  },
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text('중복 검사'),
                              ),
                            ],
                          ),
                        ),
                        SignUpPadding(
                          child: TextFormFieldStyle(
                            obscure: false,
                            label: AppLocalizations.of(context)!.password,
                            errorTxt: _errorText,
                            focusNode: _pwFocusNode,
                            onChanged: ((value) {
                              setState(() {
                                password = value;
                              });
                            }),
                            validator: (value) {
                              return value == null ||
                                      value.isEmpty ||
                                      !regex.hasMatch(value)
                                  ? AppLocalizations.of(context)!
                                      .signup_pw_invalid
                                  : null;
                            },
                          ),
                        ),
                        SignUpPadding(
                          child: TextFormFieldStyle(
                            obscure: false,
                            label: AppLocalizations.of(context)!.passwordCheck,
                            errorTxt: _pwChFocusNode.hasFocus &&
                                    password != passwordCheck
                                ? AppLocalizations.of(context)!
                                    .signup_pwCh_invalid
                                : null,
                            focusNode: _pwChFocusNode,
                            onChanged: ((value) {
                              setState(() {
                                passwordCheck = value;
                              });
                            }),
                            validator: (value) {
                              return value == null ||
                                      value.isEmpty ||
                                      password != passwordCheck
                                  ? AppLocalizations.of(context)!
                                      .signup_pwCh_invalid
                                  : null;
                            },
                          ),
                        ),
                        SignUpPadding(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormFieldStyle(
                                  obscure: false,
                                  label: '이메일',
                                  onChanged: (value) {
                                    setState(() {
                                      email = value;
                                    });
                                  },
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text('인증'),
                              )
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Hello',
                            style: DefaultTextStyle.of(context).style,
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: termsAgreement,
                              onChanged: (value) {
                                setState(() {
                                  termsAgreement = value!;
                                });
                              },
                            ),
                            Text('약관에 동의 합니다')
                          ],
                        )
                      ],
                    ),
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

class SignUpPadding extends StatefulWidget {
  const SignUpPadding({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<SignUpPadding> createState() => _SignUpPaddingState();
}

class _SignUpPaddingState extends State<SignUpPadding> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: widget.child,
    );
  }
}

class TextFormFieldStyle extends StatefulWidget {
  const TextFormFieldStyle({
    super.key,
    required this.obscure,
    required this.onChanged,
    required this.label,
    this.focusNode,
    this.validator,
    this.errorTxt,
  });

  final bool obscure;
  final FocusNode? focusNode;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;
  final String label;
  final String? errorTxt;

  @override
  State<TextFormFieldStyle> createState() => _TextFormFieldStyleState();
}

class _TextFormFieldStyleState extends State<TextFormFieldStyle> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscure,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: widget.label,
        errorText: widget.errorTxt,
      ),
      validator: widget.validator,
    );
  }
}
