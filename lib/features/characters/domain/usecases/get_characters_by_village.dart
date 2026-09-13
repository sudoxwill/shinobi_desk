import 'package:shinobi_desk/core/usecase/usecase.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/domain/repositories/character_repository.dart';
import 'package:shinobi_desk/features/characters/domain/usecases/get_all_characters.dart';

class GetCharactersByVillage
    implements Usecase<List<Character>, GetAllCharactersParam> {
  final CharacterRepository characterRepository;

  GetCharactersByVillage(this.characterRepository);

  @override
  Future<List<Character>> call(GetAllCharactersParam param) {
    return characterRepository.getAllCharacters(
      page: param.page,
      limit: param.limit,
    );
  }
}
