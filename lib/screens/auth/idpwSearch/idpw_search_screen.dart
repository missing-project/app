import 'package:flutter/material.dart';
import 'package:missing_application/screens/auth/idpwSearch/widgets/idpw_search_widgets.dart';
import 'package:missing_application/screens/global/global_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IdPwSearchScreen extends StatefulWidget {
  const IdPwSearchScreen({Key? key}) : super(key: key);

  @override
  State<IdPwSearchScreen> createState() => _IdPwSearchScreenState();
}

class _IdPwSearchScreenState extends State<IdPwSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: GlobalAppbar(),
        body: Column(
          children: [
            TabBar(
              labelColor: Theme.of(context).primaryColor,
              tabs: [
                Tab(text: AppLocalizations.of(context)!.idpw_tap_id),
                Tab(text: AppLocalizations.of(context)!.idpw_tap_pw),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  IdSearch(),
                  PwSearch(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
