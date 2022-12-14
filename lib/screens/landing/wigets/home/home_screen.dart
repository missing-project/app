import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/case/case_bloc.dart';
import 'package:missing_application/components/card/case_image_card.dart';
import 'package:missing_application/models/case_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:missing_application/screens/case/widgets/case_bloc_consumer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Case> caseList = [];
  void _caseLoaded(Case _, List<Case> list) {
    setState(() {
      caseList = list;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CaseBloc>(context).add(CaseList());
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return CaseBlocConsumer(
      loaded: _caseLoaded,
      child: ListView(
        children: [
          // Text(
          //   AppLocalizations.of(context)!.greeting(10),
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15),
                child: Text(
                  AppLocalizations.of(context)!.section,
                  style: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(
                height: deviceHeight / 2,
                child: CarouselSlider(
                  items: caseList.map((caseEl) {
                    return CaseImageCard(detail: caseEl);
                  }).toList(),
                  options: CarouselOptions(
                    disableCenter: true,
                    autoPlay: true,
                    autoPlayCurve: Curves.linear,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(seconds: 5),
                    enableInfiniteScroll: false,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
