import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.email,
  });

  final String id;
  final String email;

  @override
  List<Object> get props => [id];

  static const empty = User(id: '', email: '');

  User copywith({String? id, String? email}) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['uid'].toString(),
      email: json['email'].toString(),
    );
  }
}

class PreferencesKey {
  static String accesstoken = 'access';
  static String refreshtoken = 'refresh';
}
