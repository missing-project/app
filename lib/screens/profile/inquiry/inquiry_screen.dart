import 'package:flutter/material.dart';
import 'package:missing_application/screens/global/global_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              AppLocalizations.of(context)!.inquiry_made,
              textAlign: TextAlign.center,
            ),
            Text(AppLocalizations.of(context)!.inquiry_01),
            Text(AppLocalizations.of(context)!.inquiry_02),
            Text(AppLocalizations.of(context)!.inquiry_03),
            Text(AppLocalizations.of(context)!.inquiry_04),
            Text(
              AppLocalizations.of(context)!.inquiry_email,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
