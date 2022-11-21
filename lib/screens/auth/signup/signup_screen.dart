import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/screens/auth/signup/widgets/signup_widgets.dart';
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
  String emailAuthrizationCode = '';
  String emailCodeInputValue = '';
  bool idUsable = false;
  bool emailAuthrizationCheck = false;
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
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogCustom(
          content: value
              ? AppLocalizations.of(context)!.signup_id_duplicate_possible
              : AppLocalizations.of(context)!.signup_id_duplicate_impossible,
        );
      },
    );
  }

  void _handleEmailCheck() {
    if (email.isNotEmpty) {
      BlocProvider.of<AuthBloc>(context).add(EmailCheck(email: email));
    }
  }

  void _emailCheckState(String code) {
    setState(() {
      emailAuthrizationCode = code;
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogCustom(
            content: AppLocalizations.of(context)!.signup_emailCode_send);
      },
    );
  }

  void _emailCodeCheck() {
    bool isCorrect = (emailAuthrizationCode == emailCodeInputValue);
    setState(() {
      emailAuthrizationCheck = isCorrect;
    });
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialogCustom(
            content: isCorrect
                ? AppLocalizations.of(context)!.signup_emailCode_correct
                : AppLocalizations.of(context)!.signup_emailCode_incorrect,
          );
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
        emailCheck: _emailCheckState,
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
                                readOnly: emailAuthrizationCode.isNotEmpty,
                                suffixIcon: emailAuthrizationCheck
                                    ? Icon(Icons.check, color: Colors.green)
                                    : null,
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
                              onPressed: emailAuthrizationCheck
                                  ? null
                                  : _handleEmailCheck,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .signup_authrization,
                              ),
                            )
                          ],
                        ),
                      ),
                      emailAuthrizationCode.isNotEmpty &&
                              !emailAuthrizationCheck
                          ? SignUpPadding(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          emailCodeInputValue = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        label: Text(
                                            AppLocalizations.of(context)!
                                                .signup_emailCode_input),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: _emailCodeCheck,
                                    child: Text(
                                        AppLocalizations.of(context)!.check),
                                  )
                                ],
                              ),
                            )
                          : SizedBox(),
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
