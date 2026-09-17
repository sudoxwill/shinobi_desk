import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/core/constant/api_constants.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/characters_provider.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/get_character_by_id_provider.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/network_info_provider.dart';

final characterProvider = FutureProvider((ref) async {
  final networkInfo = ref.watch(networkInfoProvider);
  if (!await networkInfo.isConnected) {
    final characters = ref.watch(charactersProvider);
    final list = characters.value;
    if (list == null || list.isEmpty) return null;
    return list[Random().nextInt(list.length)];
  }
  final randomNumber = Random().nextInt(ApiConstants.maxCharacters + 1);
  final usecase = ref.read(getCharacterByIdProvider);

  final result = await usecase(randomNumber);
  return result;
});
