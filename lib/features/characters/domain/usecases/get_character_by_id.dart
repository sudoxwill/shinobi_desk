import 'package:shinobi_desk/core/usecase/usecase.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/domain/repositories/character_repository.dart';

class GetCharacterById implements Usecase<Character, int> {
  final CharacterRepository characterRepository;

  GetCharacterById(this.characterRepository);

  @override
  Future<Character> call(int id) {
    return characterRepository.getCharacterById(id);
  }
}
