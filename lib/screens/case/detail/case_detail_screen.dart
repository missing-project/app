import 'package:flutter/material.dart';
import 'package:missing_application/models/case_model.dart';

class CaseDetailScreen extends StatefulWidget {
  const CaseDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CaseDetailScreen> createState() => _CaseDetailScreenState();
}

class _CaseDetailScreenState extends State<CaseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final detail = ModalRoute.of(context)!.settings.arguments as Case;
    final Map<String, String> target = {
      '010': '정상아동(18세미만)',
      '020': '가출인',
      '040': '시설보호무연고자',
      '060': '지적장애인',
      '061': '지적장애인(18세미만)',
      '062': '치매질환자',
      '080': '불상(기타)',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('detail'),
      ),
      body: Column(
        children: [
          Hero(
            tag: detail.id,
            child: Image.network(
              detail.image,
            ),
          ),
          SizedBox(height: 20),
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
                  value: detail.date.substring(0, 10),
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
