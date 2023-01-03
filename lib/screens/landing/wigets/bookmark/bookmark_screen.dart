import 'package:flutter/material.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/components/card/case_row_card.dart';
import 'package:missing_application/screens/auth/widgets/auth_bloc_consumer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  Widget child(AuthState state) {
    return state is AuthLoaded
        ? state.bookmarks.isEmpty
            ? Center(child: Text(AppLocalizations.of(context)!.bookmark_nodata))
            : ListView(
                children: state.bookmarks.map((el) {
                  return CaseRowCard(
                    detail: el,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
              )
        : Center(
            child: Text(
              AppLocalizations.of(context)!.bookmark_nologin,
              textAlign: TextAlign.center,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return AuthBlocConsumer(child: child);
  }
}
