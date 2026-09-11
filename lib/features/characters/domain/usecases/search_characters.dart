import 'package:shinobi_desk/core/usecase/usecase.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/domain/repositories/character_repository.dart';

class SearchCharacters
    implements Usecase<List<Character>, SearchCharactersParam> {
  final CharacterRepository characterRepository;

  SearchCharacters(this.characterRepository);

  @override
  Future<List<Character>> call(SearchCharactersParam param) {
    return characterRepository.searchCharacters(
      query: param.query,
      page: param.page,
      limit: param.limit,
    );
  }
}

class SearchCharactersParam {
  final String query;
  final int page;
  final int limit;

  SearchCharactersParam({
    required this.query,
    required this.page,
    required this.limit,
  });
}
