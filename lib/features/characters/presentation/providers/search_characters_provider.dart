import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/features/characters/domain/usecases/search_characters.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/characters_repository_provider.dart';

final searchCharactersProvider = Provider<SearchCharacters>(
  (ref) => SearchCharacters(ref.watch(charactersRepositoryProvider)),
);
