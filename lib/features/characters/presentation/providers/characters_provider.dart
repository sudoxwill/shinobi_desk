import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/core/constant/api_constants.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/domain/usecases/get_all_characters.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/get_all_characters_provider.dart';

class CharactersNotifier extends AsyncNotifier<List<Character>> {
  @override
  FutureOr<List<Character>> build() async {
    final usecase = ref.watch(getAllCharactersProvider);
    return usecase(
      GetAllCharactersParam(
        page: ApiConstants.defaultPage,
        limit: ApiConstants.defaultLimit,
      ),
    );
  }

  Future<void> getAllCharacters({required int page, required int limit}) async {
    state = AsyncLoading();
    final usecase = ref.read(getAllCharactersProvider);
    state = await AsyncValue.guard(
      () async => usecase(GetAllCharactersParam(page: page, limit: limit)),
    );
  }
}

final charactersProvider =
    AsyncNotifierProvider<CharactersNotifier, List<Character>>(
      CharactersNotifier.new,
    );
