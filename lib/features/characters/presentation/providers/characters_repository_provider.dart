import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:shinobi_desk/features/characters/domain/repositories/character_repository.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/characters_remote_data_source_provider.dart';

final charactersRepositoryProvider = Provider<CharacterRepository>(
  (ref) =>
      CharactersRepositoryImpl(ref.watch(charactersRemoteDataSourceProvider)),
);
