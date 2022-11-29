import 'package:equatable/equatable.dart';
import 'package:missing_application/models/case_model.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    this.bookmarks = const [],
  });

  final String id;
  final String email;
  final List<Case> bookmarks;

  @override
  List<Object> get props => [id];

  static const empty = User(id: '', email: '');

  User copywith({String? id, String? email, List<Case>? bookmarks}) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      bookmarks: bookmarks ?? this.bookmarks,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      email: json['email'].toString(),
    );
  }
}
