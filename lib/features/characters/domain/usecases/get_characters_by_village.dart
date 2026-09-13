import 'package:shinobi_desk/core/usecase/usecase.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/domain/repositories/character_repository.dart';

class GetCharactersByVillage implements Usecase<List<Character>, String> {
  final CharacterRepository characterRepository;

  GetCharactersByVillage(this.characterRepository);

  @override
  Future<List<Character>> call(String village) {
    return characterRepository.getCharactersByIVillage(village);
  }
}
