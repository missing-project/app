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
    final args =
        ModalRoute.of(context)!.settings.arguments as CaseDetailArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('detail'),
      ),
      body: Hero(
        tag: args.tag,
        child: Image.network(args.source),
      ),
    );
  }
}
