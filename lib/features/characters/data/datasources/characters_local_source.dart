import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:shinobi_desk/core/constant/local_constants.dart';
import 'package:shinobi_desk/core/error/exception.dart';
import 'package:shinobi_desk/features/characters/data/models/character_model.dart';

abstract class CharactersLocalSource {
  Future<void> cacheCharacters(List<CharacterModel> characters);
  Future<List<CharacterModel>> getCharacters();
}

class CharactersLocalSourceImpl implements CharactersLocalSource {
  final Box<String> hiveBox;

  CharactersLocalSourceImpl(this.hiveBox);

  @override
  Future<void> cacheCharacters(List<CharacterModel> characters) async {
    try {
      await hiveBox.put(
        LocalConstants.allCharactersKey,
        jsonEncode(characters.map((e) => e.toJson()).toList()),
      );
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<CharacterModel>> getCharacters() async {
    try {
      final raw = hiveBox.get(LocalConstants.allCharactersKey);
      if (raw == null) return [];
      final data = jsonDecode(raw) as List<dynamic>;
      return data.map((e) => CharacterModel.fromJson(e)).toList();
    } catch (e) {
      throw CacheException();
    }
  }
}
