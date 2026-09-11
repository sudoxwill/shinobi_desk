import 'package:shinobi_desk/features/characters/domain/entities/character.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required super.id,
    required super.name,
    required super.images,
    super.jutsu,
    super.natureType,
    super.family,
    super.birthdate,
    super.sex,
    super.clan,
    super.affiliation,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    final personal = json['personal'] as Map<String, dynamic>? ?? {};
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      images: List<String>.from(json['images'] ?? []),
      jutsu: List<String>.from(json['jutsu'] ?? []),
      natureType: List<String>.from(json['natureType'] ?? []),
      family: Map<String, String>.from(json['family'] ?? {}),
      affiliation: List<String>.from(personal['affiliation'] ?? []),
      birthdate: personal['birthdate'],
      sex: personal['sex'],
      clan: personal['clan'],
    );
  }

  factory CharacterModel.fromEntity(Character character) {
    return CharacterModel(
      id: character.id,
      name: character.name,
      images: character.images,
      jutsu: character.jutsu,
      natureType: character.natureType,
      family: character.family,
      birthdate: character.birthdate,
      sex: character.sex,
      clan: character.clan,
      affiliation: character.affiliation,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'images': images,
    'jutsu': jutsu,
    'natureType': natureType,
    'family': family,
    'personal': {
      'birthdate': birthdate,
      'sex': sex,
      'clan': clan,
      'affiliation': affiliation,
    },
  };
}
