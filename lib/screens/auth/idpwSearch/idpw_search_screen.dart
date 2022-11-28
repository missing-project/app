import 'package:flutter/material.dart';
import 'package:missing_application/screens/auth/idpwSearch/widgets/idpw_search_widgets.dart';
import 'package:missing_application/screens/global/global_appbar.dart';

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
                Tab(text: '아이디 찾기'),
                Tab(text: '비밀번호 찾기'),
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
