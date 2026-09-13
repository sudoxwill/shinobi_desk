import 'package:shinobi_desk/features/characters/domain/entities/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getAllCharacters({
    required int page,
    required int limit,
  });
  Future<List<Character>> searchCharacters({
    required String query,
    required int page,
    required int limit,
  });
  Future<Character> getCharacterById(int id);
}
