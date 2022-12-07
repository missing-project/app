import 'package:flutter/material.dart';
import 'package:missing_application/screens/global/global_appbar.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  List<Item> noticelist = [
    Item(description: 'expandedValue0001', title: 'headerValue1'),
    Item(description: 'expandedValue0002', title: 'headerValue2'),
    Item(description: 'expandedValue0003', title: 'headerValue3'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('공지사항')),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              noticelist[index].isExpanded = !isExpanded;
            });
          },
          children: noticelist
              .map(
                (notice) => ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text(notice.title),
                    );
                  },
                  body: ListTile(
                    title: Text(notice.description),
                  ),
                  isExpanded: notice.isExpanded,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class Item {
  Item({
    required this.title,
    required this.description,
    this.isExpanded = false,
  });

  String title;
  String description;
  bool isExpanded;
}
