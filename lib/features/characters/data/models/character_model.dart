import 'package:shinobi_desk/features/characters/domain/entities/character.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required super.id,
    required super.name,
    required super.images,
    required super.jutsu,
    required super.natureType,
    required super.family,
    super.birthdate,
    super.sex,
    super.clan,
    required super.affiliation,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    late dynamic personal;
    if (json['personal'].runtimeType == List<dynamic>) {
      personal = <String, dynamic>{};
    } else {
      personal = json['personal'] as Map<String, dynamic>? ?? {};
    }

    return CharacterModel(
      id: json['id'],
      name: json['name'],
      images: List<String>.from(json['images'] ?? []),
      jutsu: List<String>.from(json['jutsu'] ?? []),
      natureType: List<String>.from(json['natureType'] ?? []),
      family: Map<String, String>.from(json['family'] ?? {}),
      affiliation: List<String>.from(
        _resolveListOrStringIssue('affiliation', personal) ?? [],
      ),
      birthdate: personal['birthdate'],
      sex: personal['sex'],
      clan: _resolveStringOrListIssue('clan', personal),
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

String? _resolveStringOrListIssue(String label, Map<String, dynamic> personal) {
  return personal[label] == null
      ? null
      : personal[label].runtimeType == String
      ? personal[label]
      : personal[label].first;
}

List? _resolveListOrStringIssue(String label, Map<String, dynamic> personal) {
  return personal[label] == null
      ? null
      : personal[label].runtimeType == List
      ? personal[label]
      : [personal[label]];
}
