import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/features/characters/domain/usecases/get_character_by_id.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/characters_repository_provider.dart';

final getCharacterByIdProvider = Provider<GetCharacterById>(
  (ref) => GetCharacterById(ref.watch(charactersRepositoryProvider)),
);
