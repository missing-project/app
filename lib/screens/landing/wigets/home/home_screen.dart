import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:missing_application/components/card/case_card.dart';
import 'package:missing_application/models/case_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<CaseDetailArguments> caseList = [
    CaseDetailArguments(
        tag: 'tag1', source: 'https://source.unsplash.com/mou0S7ViElQ'),
    CaseDetailArguments(
        tag: 'tag2', source: 'https://source.unsplash.com/t0Bv0OBQuTg'),
    CaseDetailArguments(
        tag: 'tag3', source: 'https://source.unsplash.com/K-sdQ12jZeY'),
    CaseDetailArguments(
        tag: 'tag4', source: 'https://source.unsplash.com/0rxLLHD1XxA'),
  ];

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        Text(
          AppLocalizations.of(context)!.greeting(10),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.section),
            SizedBox(
              height: deviceHeight / 4,
              width: deviceWidth,
              child: CarouselSlider(
                items: caseList.map((caseArgs) {
                  return CaseCard(detail: caseArgs);
                }).toList(),
                options: CarouselOptions(
                  viewportFraction: 0.6,
                  autoPlay: true,
                  autoPlayCurve: Curves.linear,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(seconds: 5),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
