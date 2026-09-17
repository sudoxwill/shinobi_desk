import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shinobi_desk/core/error/exception.dart';
import 'package:shinobi_desk/core/error/failure.dart';
import 'package:shinobi_desk/core/network/network_info.dart';
import 'package:shinobi_desk/features/characters/data/datasources/characters_local_source.dart';
import 'package:shinobi_desk/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:shinobi_desk/features/characters/data/models/character_model.dart';
import 'package:shinobi_desk/features/characters/data/repositories/characters_repository_impl.dart';

class MockCharactersRemoteDataSource extends Mock
    implements CharactersRemoteDataSource {}

class MockCharactersLocalSource extends Mock implements CharactersLocalSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late CharactersRepositoryImpl repository;
  late MockCharactersRemoteDataSource mockRemoteDataSource;
  late MockCharactersLocalSource mockLocalSource;
  late MockNetworkInfo mockNetworkInfo;

  setUpAll(() {
    // Nécessaire pour que mocktail accepte any() sur un type custom
    // (List<CharacterModel>) passé à cacheCharacters().
    registerFallbackValue(<CharacterModel>[]);
  });

  setUp(() {
    mockRemoteDataSource = MockCharactersRemoteDataSource();
    mockLocalSource = MockCharactersLocalSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CharactersRepositoryImpl(
      charactersRemoteDataSource: mockRemoteDataSource,
      charactersLocalSource: mockLocalSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tCharacters = [
    const CharacterModel(
      id: 0,
      name: 'Naruto Uzumaki',
      images: [],
      jutsu: [],
      natureType: [],
      family: {},
      affiliation: ['Konohagakure'],
    ),
  ];

  group('getAllCharacters', () {
    test(
      'récupère les personnages depuis le remote et les met en cache quand il y a une connexion',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockRemoteDataSource.getAllCharacters(page: 1, limit: 20),
        ).thenAnswer((_) async => tCharacters);
        when(
          () => mockLocalSource.cacheCharacters(any()),
        ).thenAnswer((_) async {});

        // act
        final result = await repository.getAllCharacters(page: 1, limit: 20);

        // assert
        expect(result, tCharacters);
        verify(
          () => mockRemoteDataSource.getAllCharacters(page: 1, limit: 20),
        ).called(1);
        verify(() => mockLocalSource.cacheCharacters(tCharacters)).called(1);
      },
    );

    test(
      'retourne les personnages en cache sans appeler le remote quand il n\'y a pas de connexion',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(
          () => mockLocalSource.getCharacters(),
        ).thenAnswer((_) async => tCharacters);

        // act
        final result = await repository.getAllCharacters(page: 1, limit: 20);

        // assert
        expect(result, tCharacters);
        verifyNever(
          () => mockRemoteDataSource.getAllCharacters(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
          ),
        );
        verify(() => mockLocalSource.getCharacters()).called(1);
      },
    );

    test(
      'lève une NetworkFailure quand le remote échoue avec une NetworkException',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockRemoteDataSource.getAllCharacters(page: 1, limit: 20),
        ).thenThrow(NetworkException());

        // act
        final call = repository.getAllCharacters(page: 1, limit: 20);

        // assert
        await expectLater(call, throwsA(isA<NetworkFailure>()));
      },
    );
  });
}
