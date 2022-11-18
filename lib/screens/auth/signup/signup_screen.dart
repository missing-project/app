import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/screens/auth/widgets/auth_bloc_consumer.dart';
import 'package:missing_application/screens/global/global_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  bool idUsable = false;
  bool emailAuthrization = false;
  bool termsAgreement = false;

  String? get _errorText {
    if (_pwFocusNode.hasFocus && !regex.hasMatch(password)) {
      return AppLocalizations.of(context)!.signup_pw_regex;
    }

    return null;
  }

  void _handleIdCheck() {
    if (id.isNotEmpty) {
      BlocProvider.of<AuthBloc>(context).add(IdCheck(id: id));
    }
  }

  void _idCheckState(bool value) {
    setState(() {
      idUsable = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(),
      body: AuthBlocConsumer(
        loaded: () {
          Navigator.pop(context);
        },
        idCheck: _idCheckState,
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
                              onPressed: _handleIdCheck,
                              child: Text(AppLocalizations.of(context)!
                                  .signup_id_duplicate_btn),
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
                                label:
                                    AppLocalizations.of(context)!.signup_email,
                                onChanged: (value) {
                                  setState(() {
                                    email = value;
                                  });
                                },
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(AppLocalizations.of(context)!
                                  .signup_authrization),
                            )
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.signup_terms,
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
                          Text(AppLocalizations.of(context)!.signup_terms_agree)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: termsAgreement && _formKey.currentState!.validate()
                      ? () {}
                      : null,
                  style: TextButton.styleFrom(
                    disabledBackgroundColor: Colors.grey[100],
                    disabledForegroundColor: Colors.black,
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(AppLocalizations.of(context)!.signup_btn),
                ),
              ),
            ],
          ),
        ),
      ),
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
