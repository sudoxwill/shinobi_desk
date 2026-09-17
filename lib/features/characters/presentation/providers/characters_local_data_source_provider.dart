import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shinobi_desk/core/constant/local_constants.dart';
import 'package:shinobi_desk/features/characters/data/datasources/characters_local_source.dart';

final hiveBoxProvider = Provider<Box<String>>((ref) {
  return Hive.box(LocalConstants.charactersBoxKey);
});

final charactersLocalDataSourceProvider = Provider<CharactersLocalSource>((
  ref,
) {
  return CharactersLocalSourceImpl(ref.watch(hiveBoxProvider));
});
