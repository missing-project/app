import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/screens/auth/signup/widgets/signup_widgets.dart';
import 'package:missing_application/screens/auth/widgets/auth_bloc_consumer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IdSearch extends StatefulWidget {
  const IdSearch({super.key});

  @override
  State<IdSearch> createState() => _IdSearchState();
}

class _IdSearchState extends State<IdSearch> {
  String email = '';
  String idInqured = '';

  void handleSearchId() {
    BlocProvider.of<AuthBloc>(context).add(IdSearchByEmail(email: email));
  }

  void handleIdsearchState(String uid) {
    setState(() {
      idInqured = uid;
    });
  }

  Widget child(AuthState state) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: TextFieldStyle(
                    label: '이메일',
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
                    onPressed:
                        emailRegExp.hasMatch(email) ? handleSearchId : null,
                    child: Text('조회'),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: Text(
              idInqured.isEmpty ? '조회된 아이디가 없습니다' : '조회된 아이디: $idInqured',
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthBlocConsumer(
      child: child,
      idsearch: handleIdsearchState,
    );
  }
}

class PwSearch extends StatefulWidget {
  const PwSearch({super.key});

  @override
  State<PwSearch> createState() => _PwSearchState();
}

class _PwSearchState extends State<PwSearch> {
  final _pwFocusNode = FocusNode();
  final _pwChFocusNode = FocusNode();
  String email = '';
  String codeSend = '';
  String codeInput = '';
  bool emailCheckCompleted = false;
  String password = '';
  String passwordCheck = '';
  bool passwordVisible = false;
  bool passwordCheckVisible = false;

  String? get _passwordErrorText {
    if (_pwFocusNode.hasFocus && !passwordRegex.hasMatch(password)) {
      return AppLocalizations.of(context)!.signup_pw_regex;
    }

    return null;
  }

  void handleSendEmail() {
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

  void handleEmailCheck(String authCode) {
    setState(() {
      codeSend = authCode;
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogCustom(
          content: AppLocalizations.of(context)!.signup_emailCode_send,
        );
      },
    );
  }

  void handleCodeCheck() {
    bool isCorrect = (codeSend == codeInput);
    setState(() {
      emailCheckCompleted = isCorrect;
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

  void handlePasswordChange() {}

  Widget child(AuthState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                SizedBox(height: 25),
                SizeInListView(
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormFieldStyle(
                            obscure: false,
                            readOnly: codeSend.isNotEmpty,
                            suffixIcon: emailCheckCompleted
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
                            onPressed:
                                emailCheckCompleted ? null : handleSendEmail,
                            child: Text(
                              AppLocalizations.of(context)!.signup_authrization,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                codeSend.isNotEmpty && !emailCheckCompleted
                    ? SizeInListView(
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      codeInput = value;
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
                                onPressed: handleCodeCheck,
                                child:
                                    Text(AppLocalizations.of(context)!.check),
                              )
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
                SizeInListView(
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
                  ),
                ),
                SizeInListView(
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
                    errorTxt:
                        _pwChFocusNode.hasFocus && password != passwordCheck
                            ? AppLocalizations.of(context)!.signup_pwCh_invalid
                            : null,
                    focusNode: _pwChFocusNode,
                    onChanged: ((value) {
                      setState(() {
                        passwordCheck = value;
                      });
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: emailCheckCompleted &&
                    password.isNotEmpty &&
                    (password == passwordCheck)
                ? handlePasswordChange
                : null,
            child: Text('비밀번호 변경'),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthBlocConsumer(
      child: child,
      emailCheck: handleEmailCheck,
    );
  }
}

class SizeInListView extends StatelessWidget {
  const SizeInListView({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: child,
    );
  }
}

class TextFieldStyle extends StatefulWidget {
  const TextFieldStyle({
    super.key,
    required this.label,
    required this.onChanged,
    this.obscure = false,
    this.readOnly = false,
    this.suffixIcon,
  });

  final String label;
  final void Function(String) onChanged;
  final bool obscure;
  final bool readOnly;
  final Widget? suffixIcon;

  @override
  State<TextFieldStyle> createState() => _TextFieldStyleState();
}

class _TextFieldStyleState extends State<TextFieldStyle> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: widget.readOnly,
      obscureText: widget.obscure,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        enabled: !widget.readOnly,
        border: OutlineInputBorder(),
        labelText: widget.label,
        suffixIcon: widget.suffixIcon,
      ),
      style: TextStyle(
        fontStyle: widget.readOnly ? FontStyle.italic : FontStyle.normal,
      ),
    );
  }
}
