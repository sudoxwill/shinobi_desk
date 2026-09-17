import 'package:dio/dio.dart';
import 'package:shinobi_desk/core/error/exception_mapper.dart';
import 'package:shinobi_desk/features/characters/data/models/character_model.dart';

abstract class CharactersRemoteDataSource {
  Future<List<CharacterModel>> getAllCharacters({
    required int page,
    required int limit,
  });
  Future<List<CharacterModel>> searchCharacters({
    required String query,
    required int page,
    required int limit,
  });
  Future<CharacterModel> getCharacterById(int id);
}

class CharactersRemoteDataSourceImpl implements CharactersRemoteDataSource {
  final Dio dio;

  CharactersRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CharacterModel>> getAllCharacters({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dio.get(
        '/characters',
        queryParameters: {'page': page, 'limit': limit},
      );
      final data = (response.data['characters'] as List<dynamic>)
          .map((e) => CharacterModel.fromJson(e))
          .toList();
      return data;
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  @override
  Future<CharacterModel> getCharacterById(int id) async {
    try {
      final response = await dio.get('/characters/$id');
      return CharacterModel.fromJson(response.data);
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  @override
  Future<List<CharacterModel>> searchCharacters({
    required String query,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dio.get(
        '/characters',
        queryParameters: {'name': query, 'page': page, 'limit': limit},
      );
      return (response.data['characters'] as List<dynamic>)
          .map((e) => CharacterModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
