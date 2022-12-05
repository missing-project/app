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
    required this.ageNow,
    required this.place,
    required this.image,
    required this.dress,
    required this.targetCode,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String name;
  final String date;
  final String age;
  final String ageNow;
  final String place;
  final String image;
  final String dress;
  final String targetCode;
  final double latitude;
  final double longitude;

  @override
  List<Object> get props => [];

  static const empty = Case(
    id: '',
    name: '',
    date: '',
    age: '',
    ageNow: '',
    place: '',
    image: '',
    dress: '',
    targetCode: '',
    latitude: 0,
    longitude: 0,
  );

  Case copywith({
    String? id,
    String? name,
    String? date,
    String? age,
    String? ageNow,
    String? place,
    String? image,
    String? dress,
    String? targetCode,
    double? latitude,
    double? longitude,
  }) {
    return Case(
      id: id ?? '',
      name: name ?? '',
      date: date ?? '',
      age: age ?? '',
      ageNow: ageNow ?? '',
      place: place ?? '',
      image: image ?? '',
      dress: dress ?? '',
      targetCode: targetCode ?? '',
      latitude: latitude ?? 0,
      longitude: longitude ?? 0,
    );
  }

  factory Case.fromJson(Map<String, dynamic> json) {
    return Case(
      id: json['_id'].toString(),
      name: json['nm'].toString(),
      date: json['occrDate'].toString().substring(0, 10),
      age: json['age'].toString(),
      ageNow: json['ageNow'].toString(),
      place: json['occrAdres'].toString(),
      image: json['img'].toString(),
      dress: json['alldressingDscd'].toString(),
      targetCode: json['writngTrgetDscd'].toString(),
      latitude: json['y'] ?? 0,
      longitude: json['x'] ?? 0,
    );
  }
}
