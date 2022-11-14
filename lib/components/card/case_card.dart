import 'package:flutter/material.dart';
import 'package:missing_application/models/case_model.dart';
import 'package:missing_application/routes.dart';

class CaseCard extends StatelessWidget {
  const CaseCard({
    Key? key,
    required this.detail,
  }) : super(key: key);

  final CaseDetailArguments detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            Routes.caseDetail,
            arguments: detail,
          );
        },
        child: Hero(
          tag: detail.tag,
          child: Image.network(detail.source),
        ),
      ),
    );
  }
}
