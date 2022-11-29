import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/components/card/case_row_card.dart';
import 'package:missing_application/models/case_model.dart';
import 'package:missing_application/screens/auth/widgets/auth_bloc_consumer.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  bool isLogin = false;
  List<Case> bookmarks = [];
  void handleLoaded(_) {
    setState(() {
      isLogin = true;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(GetUser());
  }

  @override
  Widget build(BuildContext context) {
    return AuthBlocConsumer(
      loaded: handleLoaded,
      child: !isLogin
          ? Center(
              child: Text(
                '로그인 해야\n\n이용할 수 있습니다',
                textAlign: TextAlign.center,
              ),
            )
          : bookmarks.isEmpty
              ? Center(child: Text('저장된 데이터가 없습니다'))
              : ListView(
                  children: bookmarks.map((el) {
                    return CaseRowCard(
                      detail: el,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
    );
  }
}
