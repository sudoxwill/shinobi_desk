import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/get_character_by_id_provider.dart';

class CharacterDetailNotifier extends AsyncNotifier<Character?> {
  @override
  FutureOr<Character?> build() => null;

  Future<void> getCharacterById(int id) async {
    state = AsyncLoading();
    final usecase = ref.read(getCharacterByIdProvider);
    state = await AsyncValue.guard(() async => usecase(id));
  }
}

final characterProvider =
    AsyncNotifierProvider<CharacterDetailNotifier, Character?>(
      CharacterDetailNotifier.new,
    );
