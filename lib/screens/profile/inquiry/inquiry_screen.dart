import 'package:flutter/material.dart';
import 'package:missing_application/screens/global/global_appbar.dart';

class InquiryScreen extends StatefulWidget {
  const InquiryScreen({Key? key}) : super(key: key);

  @override
  State<InquiryScreen> createState() => _InquiryScreenState();
}

class _InquiryScreenState extends State<InquiryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 180),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'missing 만든이',
              textAlign: TextAlign.center,
            ),
            Text('손병진'),
            Text('오승하'),
            Text('한승주'),
            Text('유상우'),
            Text(
              '문의 이메일: sgyos000@gmail.com',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
