import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/repositories/auth_repository.dart';
import 'package:missing_application/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(AuthRepository())),
      ],
      child: MaterialApp(
        title: 'Missing',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'ChosunGs',
          // elevatedButtonTheme: ElevatedButtonThemeData(
          //   style: ElevatedButton.styleFrom(
          //     disabledBackgroundColor: Colors.grey[100],
          //     disabledForegroundColor: Colors.grey[600],
          //     backgroundColor: Theme.of(context).primaryColor,
          //     foregroundColor: Colors.white,
          //   ),
          // ),
        ),
        initialRoute: '/',
        routes: routes,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ),
          child: child!,
        ),
      ),
    );
  }
}
