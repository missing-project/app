import 'package:equatable/equatable.dart';

class Appinfo extends Equatable {
  const Appinfo({
    required this.version,
    this.appstoreLink,
    this.playstoreLink,
  });

  final String version;
  final String? appstoreLink;
  final String? playstoreLink;

  @override
  List<Object> get props => [version];

  static const empty = Appinfo(version: '');

  factory Appinfo.fromJson(Map<String, dynamic> json) {
    return Appinfo(
      version: json['version'].toString(),
      appstoreLink: json['appstore'] ?? '',
      playstoreLink: json['playstore'] ?? '',
    );
  }
}
