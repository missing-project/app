import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/case/case_bloc.dart';
import 'package:missing_application/models/case_model.dart';
import 'package:missing_application/screens/global/loading_stack.dart';

class CaseBlocConsumer extends StatefulWidget {
  const CaseBlocConsumer({
    super.key,
    required this.child,
    required this.loaded,
  });

  final Widget child;
  final Function(Case caseDetail, List<Case> caselist) loaded;

  @override
  State<CaseBlocConsumer> createState() => _CaseBlocConsumerState();
}

class _CaseBlocConsumerState extends State<CaseBlocConsumer> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaseBloc, CaseState>(
      listenWhen: (previous, current) => ModalRoute.of(context)!.isCurrent,
      listener: (context, state) {
        if (state is CaseError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${state.error}')));
        }

        if (state is CaseLoaded) {
          widget.loaded(state.currentCase, state.currentCaselist);
        }
      },
      builder: (context, state) {
        return LoadingStack(
          isLoading: state is CaseLoading,
          child: widget.child,
        );
      },
    );
  }
}
