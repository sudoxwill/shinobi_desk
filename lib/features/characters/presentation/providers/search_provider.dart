import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/domain/usecases/search_characters.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/search_characters_provider.dart';

class SearchCharactersNotifier extends AsyncNotifier<List<Character>?> {
  @override
  FutureOr<List<Character>?> build() async => null;

  Future<void> searchCharacters({
    required String query,
    required int page,
    required int limit,
  }) async {
    state = AsyncLoading();
    final usecase = ref.read(searchCharactersProvider);
    state = await AsyncValue.guard(
      () async => usecase(
        SearchCharactersParam(query: query, page: page, limit: limit),
      ),
    );
  }
}

final searchProvider =
    AsyncNotifierProvider<SearchCharactersNotifier, List<Character>?>(
      SearchCharactersNotifier.new,
    );
