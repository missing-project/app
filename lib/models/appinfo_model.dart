import 'package:equatable/equatable.dart';

class Appinfo extends Equatable {
  const Appinfo({
    required this.version,
  });

  final String version;

  @override
  List<Object> get props => [version];

  static const empty = Appinfo(version: '');

  factory Appinfo.fromJson(Map<String, dynamic> json) {
    return Appinfo(
      version: json['version'].toString(),
    );
  }
}
