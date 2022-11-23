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

    return Scaffold(
      appBar: AppBar(
        title: Text('detail'),
      ),
      body: Hero(
        tag: detail.id,
        child: Image.network(detail.image),
      ),
    );
  }
}
