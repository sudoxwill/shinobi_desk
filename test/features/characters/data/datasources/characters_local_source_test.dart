import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shinobi_desk/core/constant/local_constants.dart';
import 'package:shinobi_desk/core/error/exception.dart';
import 'package:shinobi_desk/features/characters/data/datasources/characters_local_source.dart';
import 'package:shinobi_desk/features/characters/data/models/character_model.dart';

class MockBox extends Mock implements Box<String> {}

void main() {
  late CharactersLocalSourceImpl localSource;
  late MockBox mockBox;

  setUp(() {
    mockBox = MockBox();
    localSource = CharactersLocalSourceImpl(mockBox);
  });

  final tCharacters = [
    const CharacterModel(
      id: 0,
      name: 'Naruto Uzumaki',
      images: [],
      jutsu: ['Rasengan'],
      natureType: ['Wind'],
      family: {},
      affiliation: ['Konohagakure'],
    ),
  ];
  final tJson = jsonEncode(tCharacters.map((e) => e.toJson()).toList());

  group('cacheCharacters', () {
    test(
      'encode la liste en JSON et l\'écrit dans la box sous la bonne clé',
      () async {
        // arrange
        when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

        // act
        await localSource.cacheCharacters(tCharacters);

        // assert
        verify(
          () => mockBox.put(LocalConstants.allCharactersKey, tJson),
        ).called(1);
      },
    );

    test('lève une CacheException si l\'écriture dans la box échoue', () async {
      // arrange
      when(() => mockBox.put(any(), any())).thenThrow(Exception('hive error'));

      // act
      final call = localSource.cacheCharacters(tCharacters);

      // assert
      await expectLater(call, throwsA(isA<CacheException>()));
    });
  });

  group('getCharacters', () {
    test('retourne une liste vide quand la box ne contient rien', () async {
      // arrange
      when(() => mockBox.get(LocalConstants.allCharactersKey)).thenReturn(null);

      // act
      final result = await localSource.getCharacters();

      // assert
      expect(result, isEmpty);
    });

    test(
      'décode correctement le JSON stocké en liste de CharacterModel',
      () async {
        // arrange
        when(
          () => mockBox.get(LocalConstants.allCharactersKey),
        ).thenReturn(tJson);

        // act
        final result = await localSource.getCharacters();

        // assert
        // Vérifie que le round-trip jsonEncode/jsonDecode préserve les données
        // (c'est précisément ce qui évite le piège du Map<dynamic,dynamic> de Hive).
        expect(result, tCharacters);
      },
    );

    test('lève une CacheException si la box lève une erreur', () async {
      // arrange
      when(
        () => mockBox.get(LocalConstants.allCharactersKey),
      ).thenThrow(Exception('hive error'));

      // act
      final call = localSource.getCharacters();

      // assert
      await expectLater(call, throwsA(isA<CacheException>()));
    });
  });
}
