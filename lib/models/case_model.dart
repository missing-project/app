import 'package:equatable/equatable.dart';

class CaseDetailArguments extends Equatable {
  const CaseDetailArguments({required this.tag, required this.source});
  final String tag;
  final String source;

  @override
  List<Object> get props => [tag, source];
}
