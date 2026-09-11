import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String? birthdate;
  final String? sex;
  final String? clan;
  final List<String> images;
  final List<String>? affiliation;
  final List<String>? jutsu;
  final List<String>? natureType;
  final Map<String, String>? family;

  const Character({
    required this.id,
    required this.name,
    required this.images,
    this.jutsu,
    this.natureType,
    this.family,
    this.birthdate,
    this.sex,
    this.clan,
    this.affiliation,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    images,
    jutsu,
    natureType,
    family,
    birthdate,
    sex,
    clan,
    affiliation,
  ];
}
