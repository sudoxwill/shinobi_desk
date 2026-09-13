import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/core/constant/api_constants.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/get_character_by_id_provider.dart';

final characterProvider = FutureProvider((ref) async {
  final randomNumber = Random().nextInt(ApiConstants.maxCharacters + 1);
  final usecase = ref.read(getCharacterByIdProvider);
  return usecase(randomNumber);
});
