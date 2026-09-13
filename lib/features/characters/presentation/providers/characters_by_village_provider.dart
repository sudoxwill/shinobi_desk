import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/core/constant/api_constants.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/domain/usecases/get_all_characters.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/get_characters_by_village_provider.dart';

class CharactersByVillageNotifier extends AsyncNotifier<List<Character>> {
  @override
  FutureOr<List<Character>> build() => [];

  Future<void> getCharactersByVillage(String village) async {
    state = AsyncLoading();
    final usecase = ref.read(getCharactersByVillageProvider);

    try {
      final result = await usecase(
        GetAllCharactersParam(page: 1, limit: ApiConstants.maxCharacters),
      );

      state = AsyncValue.data(
        result.where((e) => e.affiliation!.contains(village)).toList(),
      );
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}

final charactersByVillageProvider =
    AsyncNotifierProvider<CharactersByVillageNotifier, List<Character>>(
      CharactersByVillageNotifier.new,
    );
