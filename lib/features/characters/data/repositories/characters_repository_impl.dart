import 'package:shinobi_desk/core/error/exception.dart';
import 'package:shinobi_desk/core/error/failure.dart';
import 'package:shinobi_desk/core/error/failure_mapper.dart';
import 'package:shinobi_desk/core/network/network_info.dart';
import 'package:shinobi_desk/features/characters/data/datasources/characters_local_source.dart';
import 'package:shinobi_desk/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/domain/repositories/character_repository.dart';

class CharactersRepositoryImpl implements CharacterRepository {
  final CharactersRemoteDataSource charactersRemoteDataSource;
  final CharactersLocalSource charactersLocalSource;
  final NetworkInfo networkInfo;

  CharactersRepositoryImpl({
    required this.charactersRemoteDataSource,
    required this.charactersLocalSource,
    required this.networkInfo,
  });

  @override
  Future<List<Character>> getAllCharacters({
    required int page,
    required int limit,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await charactersRemoteDataSource.getAllCharacters(
          page: page,
          limit: limit,
        );
        try {
          await charactersLocalSource.cacheCharacters(result);
        } on Exception catch (_) {
          // Erreur de l'écriture cache
          //Mais on a des données donc on ignore
        }
        return result;
      }

      return await charactersLocalSource.getCharacters();
    } on CustomException catch (e) {
      throw mapExceptionToFailure(e);
    } catch (e) {
      print(e);
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
}
