import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/get_characters_by_village.dart';

class CharactersByVillageNotifier extends AsyncNotifier<List<Character>> {
  @override
  FutureOr<List<Character>> build() => [];

  Future<void> getCharactersByVillage(String village) async {
    state = AsyncLoading();
    final usecase = ref.read(getCharactersByVillageProvider);
    state = await AsyncValue.guard(() async => usecase(village));
  }
}

final charactersByVillageProvider =
    AsyncNotifierProvider<CharactersByVillageNotifier, List<Character>>(
      CharactersByVillageNotifier.new,
    );
