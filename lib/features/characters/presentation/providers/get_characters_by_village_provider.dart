import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/features/characters/domain/usecases/get_characters_by_village.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/characters_repository_provider.dart';

final getCharactersByVillageProvider = Provider<GetCharactersByVillage>(
  (ref) => GetCharactersByVillage(ref.watch(charactersRepositoryProvider)),
);
