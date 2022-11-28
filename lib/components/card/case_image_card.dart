import 'package:flutter/material.dart';
import 'package:missing_application/models/case_model.dart';
import 'package:missing_application/routes.dart';

class CaseImageCard extends StatelessWidget {
  const CaseImageCard({
    Key? key,
    required this.detail,
  }) : super(key: key);

  final Case detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            Routes.caseDetail,
            arguments: detail,
          );
        },
        child: Hero(
          tag: detail.id,
          child: Image.network(
            detail.image,
          ),
        ),
      ),
    );
  }
}
