import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/routes.dart';
import 'package:missing_application/screens/auth/signup/signup_widgets.dart';
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
  String id = '';
  String password = '';
  String passwordCheck = '';
  String email = '';
  String emailAuthrizationCode = '';
  String emailCodeInputValue = '';
  bool passwordVisible = false;
  bool passwordCheckVisible = false;
  bool idUsable = false;
  bool emailAuthrizationCheck = false;
  bool termsAgreement = false;

  String? get _passwordErrorText {
    if (_pwFocusNode.hasFocus && !passwordRegex.hasMatch(password)) {
      return AppLocalizations.of(context)!.signup_pw_regex;
    }

    return null;
  }

  void _handleIdCheck() {
    if (id.isNotEmpty) {
      BlocProvider.of<AuthBloc>(context).add(IdCheck(id: id));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialogCustom(
            content: AppLocalizations.of(context)!.signup_id_invalid,
          );
        },
      );
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
    if (email.isNotEmpty && emailRegExp.hasMatch(email)) {
      BlocProvider.of<AuthBloc>(context).add(EmailCheck(email: email));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialogCustom(
            content: AppLocalizations.of(context)!.signup_email_regExp,
          );
        },
      );
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

  void _handleCheckTermsAgreement() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.all(10),
          contentPadding: EdgeInsets.all(5),
          actionsPadding: EdgeInsets.all(5),
          title: Text('개인정보 처리방침'),
          content: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            height: MediaQuery.of(context).size.height / 2,
            child: SingleChildScrollView(
              child: SignupTerms(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.check),
            )
          ],
        );
      },
    );
  }

  void _handleSignupSubmit() {
    if (!idUsable) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialogCustom(
            content: '아이디 중복을 검사하세요',
          );
        },
      );
      return;
    }

    if (!emailAuthrizationCheck) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialogCustom(
            content: '이메일을 인증하세요',
          );
        },
      );
      return;
    }

    BlocProvider.of<AuthBloc>(context)
        .add(Signup(id: id, email: email, password: password));
  }

  void _signupComplete() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialogCustom(
            content: '회원가입 성공',
            action: () {
              Navigator.popUntil(context, ModalRoute.withName(Routes.login));
            },
          );
        });
  }

  Widget child(AuthState state) {
    return Form(
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
                    child: RowWithHeight(
                      children: [
                        Expanded(
                          child: TextFormFieldStyle(
                            obscure: false,
                            readOnly: idUsable,
                            suffixIcon: idUsable
                                ? Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : null,
                            label: AppLocalizations.of(context)!.id,
                            onChanged: ((value) {
                              setState(() {
                                id = value;
                              });
                            }),
                          ),
                        ),
                        SizedBox(
                          height: double.infinity,
                          child: ElevatedButton(
                            onPressed: idUsable ? null : _handleIdCheck,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .signup_id_duplicate_btn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SignUpPadding(
                    child: TextFormFieldStyle(
                      obscure: !passwordVisible,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      label: AppLocalizations.of(context)!.password,
                      errorTxt: _passwordErrorText,
                      focusNode: _pwFocusNode,
                      onChanged: ((value) {
                        setState(() {
                          password = value;
                        });
                      }),
                      validator: (value) {
                        return value == null ||
                                value.isEmpty ||
                                !passwordRegex.hasMatch(value)
                            ? AppLocalizations.of(context)!.signup_pw_invalid
                            : null;
                      },
                    ),
                  ),
                  SignUpPadding(
                    child: TextFormFieldStyle(
                      obscure: !passwordCheckVisible,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordCheckVisible = !passwordCheckVisible;
                          });
                        },
                        icon: Icon(
                          passwordCheckVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      label: AppLocalizations.of(context)!.passwordCheck,
                      errorTxt: _pwChFocusNode.hasFocus &&
                              password != passwordCheck
                          ? AppLocalizations.of(context)!.signup_pwCh_invalid
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
                            ? AppLocalizations.of(context)!.signup_pwCh_invalid
                            : null;
                      },
                    ),
                  ),
                  SignUpPadding(
                    child: RowWithHeight(
                      children: [
                        Expanded(
                          child: TextFormFieldStyle(
                            obscure: false,
                            readOnly: emailAuthrizationCode.isNotEmpty,
                            suffixIcon: emailAuthrizationCheck
                                ? Icon(Icons.check, color: Colors.green)
                                : null,
                            label: AppLocalizations.of(context)!.signup_email,
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: double.infinity,
                          child: ElevatedButton(
                            onPressed: emailAuthrizationCheck
                                ? null
                                : _handleEmailCheck,
                            child: Text(
                              AppLocalizations.of(context)!.signup_authrization,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  emailAuthrizationCode.isNotEmpty && !emailAuthrizationCheck
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
                                    label: Text(AppLocalizations.of(context)!
                                        .signup_emailCode_input),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: _emailCodeCheck,
                                child:
                                    Text(AppLocalizations.of(context)!.check),
                              )
                            ],
                          ),
                        )
                      : SizedBox(),
                  SignUpPadding(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: termsAgreement,
                              onChanged: (value) {
                                setState(() {
                                  termsAgreement = value!;
                                });
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)!.signup_terms_agree,
                            ),
                          ],
                        ),
                        OutlinedButton(
                          onPressed: _handleCheckTermsAgreement,
                          child: Text('내용 보기'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: termsAgreement &&
                      _formKey.currentState!.validate() &&
                      state is! AuthLoading
                  ? _handleSignupSubmit
                  : null,
              child: Text(AppLocalizations.of(context)!.signup_btn),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(),
      body: AuthBlocConsumer(
        idCheck: _idCheckState,
        emailCheck: _emailCheckState,
        initial: _signupComplete,
        child: child,
      ),
    );
  }
}
