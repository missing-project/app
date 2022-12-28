import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/models/case_model.dart';
import 'package:missing_application/screens/auth/widgets/auth_bloc_consumer.dart';
import 'package:missing_application/screens/global/image_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CaseDetailScreen extends StatefulWidget {
  const CaseDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CaseDetailScreen> createState() => _CaseDetailScreenState();
}

class _CaseDetailScreenState extends State<CaseDetailScreen> {
  void handleBookmark(Case element, bool isBookMark, bool isLogin) {
    if (isLogin) {
      BlocProvider.of<AuthBloc>(context).add(
        isBookMark
            ? BookMarkDel(element: element)
            : BookMarkAdd(element: element),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('로그인해야 이용할 수 있습니다'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.check),
              )
            ],
          );
        },
      );
    }
  }

  Widget child(AuthState state) {
    final Map<String, String> target = {
      '010': AppLocalizations.of(context)!.case_010,
      '020': AppLocalizations.of(context)!.case_020,
      '040': AppLocalizations.of(context)!.case_040,
      '060': AppLocalizations.of(context)!.case_060,
      '061': AppLocalizations.of(context)!.case_061,
      '062': AppLocalizations.of(context)!.case_062,
      '080': AppLocalizations.of(context)!.case_080,
    };
    final detail = ModalRoute.of(context)!.settings.arguments as Case;
    bool isLogin = state is AuthLoaded;
    bool isBookMark = isLogin
        ? state.bookmarks.indexWhere((el) => el.id == detail.id) > -1
        : false;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.case_detail_appbar),
      ),
      body: Column(
        children: [
          Hero(
            tag: detail.id,
            child: ImageBuilder(url: detail.image),
          ),
          SizedBox(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    handleBookmark(detail, isBookMark, isLogin);
                  },
                  icon: Icon(
                    isBookMark ? Icons.bookmark : Icons.bookmark_outline,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                DetailPropety(
                  property: AppLocalizations.of(context)!.case_detail_name,
                  value: detail.name,
                ),
                DetailPropety(
                  property: AppLocalizations.of(context)!.case_detail_target,
                  value: target[detail.targetCode] ??
                      AppLocalizations.of(context)!.case_080,
                ),
                DetailPropety(
                  property: AppLocalizations.of(context)!.case_detail_date,
                  value: detail.date,
                ),
                DetailPropety(
                  property: AppLocalizations.of(context)!.case_detail_place,
                  value: detail.place,
                ),
                DetailPropety(
                  property: AppLocalizations.of(context)!.case_detail_agePrev,
                  value: detail.age,
                ),
                DetailPropety(
                  property: AppLocalizations.of(context)!.case_detail_ageCurr,
                  value: detail.ageNow,
                ),
                DetailPropety(
                  property: AppLocalizations.of(context)!.case_detail_cloth,
                  value: detail.dress,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthBlocConsumer(child: child);
  }
}

class DetailPropety extends StatelessWidget {
  const DetailPropety({
    super.key,
    required this.property,
    required this.value,
  });

  final String property;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SingleChildScrollView(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              width: MediaQuery.of(context).size.width / 4,
              child: Text(property),
            ),
            Text(value == 'null' ? '정보 없음' : value),
          ],
        ),
      ),
    );
  }
}
