import 'package:flutter/material.dart';
import 'package:missing_application/models/case_model.dart';
import 'package:missing_application/routes.dart';

class CaseRowCard extends StatelessWidget {
  const CaseRowCard({
    super.key,
    required this.detail,
    this.width,
    this.shadow,
    this.border,
    this.radius = 0,
  });

  final Case detail;
  final double? width;
  final BoxShadow? shadow;
  final BoxBorder? border;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.caseDetail,
          arguments: detail,
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        height: 100,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radius > 0 ? BorderRadius.circular(radius) : null,
          border: border,
          boxShadow: [shadow ?? BoxShadow()],
        ),
        child: Row(
          children: [
            Hero(
                tag: detail.id,
                child: detail.image.isNotEmpty
                    ? Image.network(detail.image)
                    : SizedBox()),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [Text('이름: '), Text(detail.name)]),
                Row(children: [Text('날짜: '), Text(detail.date)]),
                Row(children: [Text('장소: '), Text(detail.place)]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
