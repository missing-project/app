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
  });

  final Case detail;
  final double? width;
  final BoxShadow? shadow;
  final BoxBorder? border;

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
        height: 100,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: border,
          boxShadow: [shadow ?? BoxShadow()],
        ),
        child: Text(detail.id),
      ),
    );
  }
}
