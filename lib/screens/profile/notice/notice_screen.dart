import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/notice/notice_bloc.dart';
import 'package:missing_application/screens/global/loading_stack.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  List<bool> expandedList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NoticeBloc>(context).add(GetNotice());
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<NoticeBloc>(context).add(InitNotice());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoticeBloc, NoticeState>(
      listenWhen: (previous, current) => ModalRoute.of(context)!.isCurrent,
      listener: (context, state) {
        if (state is NoticeLoaded) {
          setState(() {
            expandedList = state.noticeList.map((e) => false).toList();
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.notice_appbar_title,
              ),
            ),
            body: LoadingStack(
              isLoading: state is NoticeLoading,
              child: state is NoticeLoaded
                  ? SingleChildScrollView(
                      child: ExpansionPanelList(
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            expandedList[index] = !isExpanded;
                          });
                        },
                        children: state.noticeList
                            .map(
                              (notice) => ExpansionPanel(
                                headerBuilder: (context, _) {
                                  return ListTile(
                                    title: Text(notice.title),
                                  );
                                },
                                body: ListTile(
                                  title: Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: Text(notice.content),
                                  ),
                                ),
                                isExpanded: expandedList[
                                    state.noticeList.indexOf(notice)],
                              ),
                            )
                            .toList(),
                      ),
                    )
                  : Center(
                      child: Text(
                        AppLocalizations.of(context)!.notice_nodata,
                      ),
                    ),
            ));
      },
    );
  }
}
