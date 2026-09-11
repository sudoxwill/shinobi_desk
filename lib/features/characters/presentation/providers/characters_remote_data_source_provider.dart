import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/dio_provider.dart';

final charactersRemoteDataSourceProvider = Provider<CharactersRemoteDataSource>(
  (ref) => CharactersRemoteDataSourceImpl(ref.watch(dioProvider)),
);
