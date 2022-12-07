import 'package:equatable/equatable.dart';

class Notice extends Equatable {
  const Notice({
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  List<Object> get props => [title, content];

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      title: json['title'].toString(),
      content: json['content'].toString(),
    );
  }
}
