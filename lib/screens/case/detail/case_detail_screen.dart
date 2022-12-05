import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/models/auth_model.dart';
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
  final Map<String, String> target = {
    '010': '정상아동(18세미만)',
    '020': '가출인',
    '040': '시설보호무연고자',
    '060': '지적장애인',
    '061': '지적장애인(18세미만)',
    '062': '치매질환자',
    '080': '불상(기타)',
  };

  bool isLogin = false;
  List<Case> bookmarks = [];

  void handleLoaded(_, List<Case> bookmarklist) {
    setState(() {
      isLogin = true;
      bookmarks = bookmarklist;
    });
  }

  void handleBookmark(Case element, bool isBookMark) {
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

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(GetUser());
  }

  @override
  Widget build(BuildContext context) {
    final detail = ModalRoute.of(context)!.settings.arguments as Case;
    bool isBookMark = bookmarks.indexWhere((el) => el.id == detail.id) > -1;
    return AuthBlocConsumer(
      loaded: handleLoaded,
      child: Scaffold(
        appBar: AppBar(
          title: Text('detail'),
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
                      handleBookmark(detail, isBookMark);
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
                  DetailPropety(property: '이름', value: detail.name),
                  DetailPropety(
                    property: '대상',
                    value: target[detail.targetCode] ?? '불상(기타)',
                  ),
                  DetailPropety(
                    property: '실종 날짜',
                    value: detail.date,
                  ),
                  DetailPropety(property: '실종 장소', value: detail.place),
                  DetailPropety(property: '당시 나이', value: detail.age),
                  DetailPropety(property: '현재 나이', value: detail.ageNow),
                  DetailPropety(property: '의상 차림', value: detail.dress),
                ],
              ),
            )
          ],
        ),
      ),
    );
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
