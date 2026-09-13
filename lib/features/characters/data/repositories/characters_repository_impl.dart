import 'package:shinobi_desk/core/error/exception.dart';
import 'package:shinobi_desk/core/error/failure.dart';
import 'package:shinobi_desk/core/error/failure_mapper.dart';
import 'package:shinobi_desk/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/domain/repositories/character_repository.dart';

class CharactersRepositoryImpl implements CharacterRepository {
  final CharactersRemoteDataSource charactersRemoteDataSource;

  CharactersRepositoryImpl(this.charactersRemoteDataSource);
  @override
  Future<List<Character>> getAllCharacters({
    required int page,
    required int limit,
  }) async {
    try {
      return await charactersRemoteDataSource.getAllCharacters(
        page: page,
        limit: limit,
      );
    } on CustomException catch (e) {
      throw mapExceptionToFailure(e);
    } catch (e) {
      throw UnexpectedFailure();
    }
  }

  @override
  Future<Character> getCharacterById(int id) async {
    try {
      return await charactersRemoteDataSource.getCharacterById(id);
    } on CustomException catch (e) {
      throw mapExceptionToFailure(e);
    } catch (e) {
      throw UnexpectedFailure();
    }
  }

  @override
  Future<List<Character>> searchCharacters({
    required String query,
    required int page,
    required int limit,
  }) async {
    try {
      return await charactersRemoteDataSource.searchCharacters(
        query: query,
        page: page,
        limit: limit,
      );
    } on CustomException catch (e) {
      throw mapExceptionToFailure(e);
    } catch (e) {
      throw UnexpectedFailure();
    }
  }

  @override
  Future<List<Character>> getCharactersByIVillage(String village) async {
    try {
      return await charactersRemoteDataSource.getCharactersByIVillage(village);
    } on CustomException catch (e) {
      throw mapExceptionToFailure(e);
    } catch (e) {
      throw UnexpectedFailure();
    }
  }
}
