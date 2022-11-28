import 'package:flutter/material.dart';
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
  List<Case> bookmarks = [
    // Case(
    //   id: 'id',
    //   name: 'name',
    //   date: 'date',
    //   age: 'age',
    //   ageNow: 'ageNow',
    //   place: 'place',
    //   image:
    //       'https://www.safe182.go.kr/api/lcm/imgView.do?msspsnIdntfccd=5470099',
    //   dress: 'dress',
    //   targetCode: 'targetCode',
    //   latitude: 0,
    //   longitude: 0,
    // ),
    // Case(
    //   id: 'id',
    //   name: 'name',
    //   date: 'date',
    //   age: 'age',
    //   ageNow: 'ageNow',
    //   place: 'place',
    //   image:
    //       'https://www.safe182.go.kr/api/lcm/imgView.do?msspsnIdntfccd=5470099',
    //   dress: 'dress',
    //   targetCode: 'targetCode',
    //   latitude: 0,
    //   longitude: 0,
    // ),
  ];
  void handleLoaded() {
    setState(() {
      isLogin = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthBlocConsumer(
      loaded: handleLoaded,
      child: !isLogin
          ? Center(child: Text('회원가입을 하셔야\n\n이용할 수 있습니다'))
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
