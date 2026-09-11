import 'package:shinobi_desk/core/usecase/usecase.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/domain/repositories/character_repository.dart';

class GetAllCharacters
    implements Usecase<List<Character>, GetAllCharactersParam> {
  final CharacterRepository characterRepository;

  GetAllCharacters(this.characterRepository);

  @override
  Future<List<Character>> call(GetAllCharactersParam param) {
    return characterRepository.getAllCharacters(
      page: param.page,
      limit: param.limit,
    );
  }
}

class GetAllCharactersParam {
  final int page;
  final int limit;

  GetAllCharactersParam({required this.page, required this.limit});
}
