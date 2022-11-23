import 'package:equatable/equatable.dart';

class CaseDetailArguments extends Equatable {
  const CaseDetailArguments({required this.tag, required this.source});
  final String tag;
  final String source;

  @override
  List<Object> get props => [tag, source];
}

class Case extends Equatable {
  const Case({
    required this.id,
    required this.name,
    required this.date,
    required this.age,
    required this.place,
    required this.image,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String name;
  final String date;
  final String age;
  final String place;
  final String image;
  final double latitude;
  final double longitude;

  @override
  List<Object> get props => [];

  static const empty = Case(
    id: '',
    name: '',
    date: '',
    age: '',
    place: '',
    image: '',
    latitude: 0,
    longitude: 0,
  );

  Case copywith({
    String? id,
    String? name,
    String? date,
    String? age,
    String? place,
    String? image,
    double? latitude,
    double? longitude,
  }) {
    return Case(
      id: id ?? '',
      name: name ?? '',
      date: date ?? '',
      age: age ?? '',
      place: place ?? '',
      image: image ?? '',
      latitude: latitude ?? 0,
      longitude: longitude ?? 0,
    );
  }

  factory Case.fromJson(Map<String, dynamic> json) {
    return Case(
      id: json['id'].toString(),
      name: json['id'].toString(),
      date: json['id'].toString(),
      age: json['id'].toString(),
      place: json['id'].toString(),
      image: json['id'].toString(),
      latitude: json['id'],
      longitude: json['id'],
    );
  }
}
