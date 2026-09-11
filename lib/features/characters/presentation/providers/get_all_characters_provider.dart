import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/features/characters/domain/usecases/get_all_characters.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/characters_repository_provider.dart';

final getAllCharactersProvider = Provider<GetAllCharacters>(
  (ref) => GetAllCharacters(ref.watch(charactersRepositoryProvider)),
);
