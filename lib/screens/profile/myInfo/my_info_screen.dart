import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/routes.dart';
import 'package:missing_application/screens/auth/widgets/auth_bloc_consumer.dart';
import 'package:missing_application/screens/profile/myInfo/my_info_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({Key? key}) : super(key: key);

  @override
  State<MyInfoScreen> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  void handleChangePassword() {
    showDialog(
        context: context,
        builder: (context) {
          return PasswrodChangeDialog();
        });
  }

  void handleLogout() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(AppLocalizations.of(context)!.myinfo_logout_content),
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.check),
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(Logout());
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void handleSignout() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(AppLocalizations.of(context)!.myinfo_signout_content),
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.check),
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(Signout());
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void handleInitial() {
    Navigator.popUntil(context, ModalRoute.withName(Routes.landing));
  }

  void handleChangePasswordComplete(_, __) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(AppLocalizations.of(context)!.myinfo_changepw_complete),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context)!.check),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Widget child(AuthState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myinfo_appbar_title),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${AppLocalizations.of(context)!.myinfo_email}: ${state is AuthLoaded ? state.user.email : ''}',
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: handleChangePassword,
                child: Text(AppLocalizations.of(context)!.myinfo_btn_changepw),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: handleLogout,
                    child: Text(
                      AppLocalizations.of(context)!.myinfo_btn_logout,
                    ),
                  ),
                  TextButton(
                    onPressed: handleSignout,
                    child: Text(
                      AppLocalizations.of(context)!.myinfo_btn_signout,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthBlocConsumer(
      loaded: handleChangePasswordComplete,
      initial: handleInitial,
      child: child,
    );
  }
}
