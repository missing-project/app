import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/appinfo/appinfo_bloc.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/blocs/case/case_bloc.dart';
import 'package:missing_application/blocs/notice/notice_bloc.dart';
import 'package:missing_application/repositories/auth_repository.dart';
import 'package:missing_application/repositories/case_repository.dart';
import 'package:missing_application/repositories/guest_repository.dart';
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
        BlocProvider(create: (_) => CaseBloc(CaseRepository())),
        BlocProvider(create: (_) => NoticeBloc(NoticeRepository())),
        BlocProvider(create: (_) => AppinfoBloc(AppinfoRepository())),
      ],
      child: MaterialApp(
        title: 'Missing',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          fontFamily: 'ChosunGs',
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
