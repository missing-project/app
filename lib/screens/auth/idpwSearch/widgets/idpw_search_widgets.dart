import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/routes.dart';
import 'package:missing_application/screens/auth/signup/signup_widgets.dart';
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
          SizeInListView(
            child: Row(
              children: [
                Expanded(
                  child: TextFieldStyle(
                    label: AppLocalizations.of(context)!.email,
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
                        emailRegExp.hasMatch(email) && state is! AuthLoading
                            ? handleSearchId
                            : null,
                    child: Text(AppLocalizations.of(context)!.idpw_lookup),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: Text(
              idInqured.isEmpty
                  ? AppLocalizations.of(context)!.idpw_result_none
                  : '${AppLocalizations.of(context)!.idpw_result_id} $idInqured',
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
  String id = '';
  String email = '';

  void handlePasswordIssued() {
    BlocProvider.of<AuthBloc>(context)
        .add(PasswordReset(uid: id, email: email));
  }

  void handleInitial() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogCustom(
          content: AppLocalizations.of(context)!.idpw_pw_send,
          action: () {
            Navigator.popUntil(context, ModalRoute.withName(Routes.login));
          },
        );
      },
    );
  }

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
                  child: TextFieldStyle(
                    label: AppLocalizations.of(context)!.id,
                    onChanged: (value) {
                      setState(() {
                        id = value;
                      });
                    },
                  ),
                ),
                SizeInListView(
                  child: TextFieldStyle(
                    label: AppLocalizations.of(context)!.signup_email,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: id.isNotEmpty &&
                    email.isNotEmpty &&
                    emailRegExp.hasMatch(email) &&
                    state is! AuthLoading
                ? handlePasswordIssued
                : null,
            child: Text(AppLocalizations.of(context)!.idpw_pw_btn),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthBlocConsumer(
      child: child,
      initial: handleInitial,
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
      padding: EdgeInsets.only(bottom: 15),
      child: SizedBox(
        height: 60,
        child: child,
      ),
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
