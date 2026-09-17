import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shinobi_desk/core/error/exception.dart';
import 'package:shinobi_desk/core/error/failure.dart';
import 'package:shinobi_desk/core/network/auth_local_storage.dart';
import 'package:shinobi_desk/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shinobi_desk/features/auth/data/models/app_user_model.dart';
import 'package:shinobi_desk/features/auth/data/models/auth_session_model.dart';
import 'package:shinobi_desk/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:shinobi_desk/features/auth/domain/entities/app_user.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalStorage extends Mock implements AuthLocalStorage {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalStorage mockLocalStorage;

  setUpAll(() {
    // Nécessaire pour any() sur un paramètre nommé de type AppUser
    // (saveTokens(user: any(named: 'user'))).
    registerFallbackValue(const AppUser(id: '', email: ''));
  });

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalStorage = MockAuthLocalStorage();
    repository = AuthRepositoryImpl(
      authRemoteDataSource: mockRemoteDataSource,
      tokenStorage: mockLocalStorage,
    );
  });

  const tUser = AppUserModel(id: 'user-1', email: 'naruto@konoha.jp');
  const tSession = AuthSessionModel(
    accessToken: 'access-token',
    refreshToken: 'refresh-token',
    user: tUser,
  );

  group('login', () {
    test(
      'sauvegarde la session et retourne l\'utilisateur quand le remote réussit',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => tSession);
        when(
          () => mockLocalStorage.saveTokens(
            accessToken: any(named: 'accessToken'),
            refreshToken: any(named: 'refreshToken'),
            user: any(named: 'user'),
          ),
        ).thenAnswer((_) async {});

        // act
        final result = await repository.login(
          email: 'naruto@konoha.jp',
          password: 'rasengan123',
        );

        // assert
        expect(result, tUser);
        verify(
          () => mockLocalStorage.saveTokens(
            accessToken: 'access-token',
            refreshToken: 'refresh-token',
            user: tUser,
          ),
        ).called(1);
      },
    );

    test(
      'lève une AuthFailure avec le message du serveur quand les identifiants sont invalides',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(const AuthException(message: 'Invalid login credentials'));

        // act
        final call = repository.login(
          email: 'naruto@konoha.jp',
          password: 'wrong-password',
        );

        // assert
        await expectLater(
          call,
          throwsA(
            isA<AuthFailure>().having(
              (f) => f.message,
              'message',
              'Invalid login credentials',
            ),
          ),
        );
        verifyNever(
          () => mockLocalStorage.saveTokens(
            accessToken: any(named: 'accessToken'),
            refreshToken: any(named: 'refreshToken'),
            user: any(named: 'user'),
          ),
        );
      },
    );
  });

  group('logout', () {
    test(
      'efface la session locale même si l\'appel réseau de déconnexion échoue',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.logout(),
        ).thenThrow(const NetworkException());
        when(() => mockLocalStorage.clearTokens()).thenAnswer((_) async {});

        // act & assert : ne doit PAS lever d'exception malgré l'échec réseau
        await expectLater(repository.logout(), completes);
        verify(() => mockLocalStorage.clearTokens()).called(1);
      },
    );
  });
}
