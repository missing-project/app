import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/screens/auth/signup/signup_widgets.dart';

class PasswrodChangeDialog extends StatefulWidget {
  const PasswrodChangeDialog({super.key});

  @override
  State<PasswrodChangeDialog> createState() => _PasswrodChangeDialogState();
}

class _PasswrodChangeDialogState extends State<PasswrodChangeDialog> {
  final _pwFocusNode = FocusNode();
  final _pwChFocusNode = FocusNode();
  String prevPassword = '';
  String currPassword = '';
  String currPasswordCheck = '';
  bool prevPasswordVisible = false;
  bool currPasswordVisible = false;
  bool currPasswordCheckVisible = false;

  String? get _passwordErrorText {
    if (_pwFocusNode.hasFocus && !passwordRegex.hasMatch(currPassword)) {
      return AppLocalizations.of(context)!.signup_pw_regex;
    }

    return null;
  }

  void handleChangePassword() {
    BlocProvider.of<AuthBloc>(context)
        .add(PasswordChange(prev: prevPassword, curr: currPassword));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        width: width / 1.1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyinfoTextFieldStyle(
                label: '현재 비밀번호',
                obscure: !prevPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(prevPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      prevPasswordVisible = !prevPasswordVisible;
                    });
                  },
                ),
                onChanged: (value) {
                  setState(() {
                    prevPassword = value;
                  });
                }),
            MyinfoTextFieldStyle(
                label: '새 비밀번호',
                obscure: !currPasswordVisible,
                errorTxt: _passwordErrorText,
                focusNode: _pwFocusNode,
                suffixIcon: IconButton(
                  icon: Icon(currPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      currPasswordVisible = !currPasswordVisible;
                    });
                  },
                ),
                onChanged: (value) {
                  setState(() {
                    currPassword = value;
                  });
                }),
            MyinfoTextFieldStyle(
                label: '새 비밀번호 확인',
                obscure: !currPasswordCheckVisible,
                focusNode: _pwChFocusNode,
                errorTxt:
                    _pwChFocusNode.hasFocus && currPassword != currPasswordCheck
                        ? AppLocalizations.of(context)!.signup_pwCh_invalid
                        : null,
                suffixIcon: IconButton(
                  icon: Icon(currPasswordCheckVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      currPasswordCheckVisible = !currPasswordCheckVisible;
                    });
                  },
                ),
                onChanged: (value) {
                  setState(() {
                    currPasswordCheck = value;
                  });
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('취소')),
                TextButton(
                    onPressed: prevPassword.isNotEmpty &&
                            currPassword.isNotEmpty &&
                            currPasswordCheck.isNotEmpty &&
                            currPassword == currPasswordCheck &&
                            passwordRegex.hasMatch(currPassword)
                        ? handleChangePassword
                        : null,
                    child: Text('변경')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyinfoTextFieldStyle extends StatefulWidget {
  const MyinfoTextFieldStyle({
    super.key,
    required this.label,
    required this.onChanged,
    this.obscure = false,
    this.readOnly = false,
    this.suffixIcon,
    this.errorTxt,
    this.focusNode,
  });

  final String label;
  final void Function(String) onChanged;
  final bool obscure;
  final bool readOnly;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final String? errorTxt;

  @override
  State<MyinfoTextFieldStyle> createState() => _MyinfoTextFieldStyleState();
}

class _MyinfoTextFieldStyleState extends State<MyinfoTextFieldStyle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: TextField(
        readOnly: widget.readOnly,
        obscureText: widget.obscure,
        onChanged: widget.onChanged,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          enabled: !widget.readOnly,
          border: OutlineInputBorder(),
          labelText: widget.label,
          errorText: widget.errorTxt,
          suffixIcon: widget.suffixIcon,
        ),
        style: TextStyle(
          fontStyle: widget.readOnly ? FontStyle.italic : FontStyle.normal,
        ),
      ),
    );
  }
}
