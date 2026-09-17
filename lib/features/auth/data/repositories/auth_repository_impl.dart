import 'package:shinobi_desk/core/error/exception.dart';
import 'package:shinobi_desk/core/error/failure.dart';
import 'package:shinobi_desk/core/error/failure_mapper.dart';
import 'package:shinobi_desk/core/network/auth_local_storage.dart';
import 'package:shinobi_desk/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shinobi_desk/features/auth/domain/entities/app_user.dart';
import 'package:shinobi_desk/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalStorage tokenStorage;
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({
    required this.tokenStorage,
    required this.authRemoteDataSource,
  });

  @override
  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    try {
      final data = await authRemoteDataSource.login(
        email: email,
        password: password,
      );
      await tokenStorage.saveTokens(
        accessToken: data.accessToken,
        refreshToken: data.refreshToken,
        user: data.user,
      );
      return data.user;
    } on CustomException catch (e) {
      throw mapExceptionToFailure(e);
    } catch (e) {
      throw UnexpectedFailure();
    }
  }

  @override
  Future<void> logout() async {
    try {
      try {
        await authRemoteDataSource.logout();
      } catch (_) {
        // Cache effacé mais erreur reseau
        // On ignore pour le moment
      }

      await tokenStorage.clearTokens();
    } on CustomException catch (e) {
      throw mapExceptionToFailure(e);
    } catch (e) {
      throw UnexpectedFailure();
    }
  }

  @override
  Future<AppUser> register({
    required String email,
    required String password,
  }) async {
    try {
      final data = await authRemoteDataSource.register(
        email: email,
        password: password,
      );
      await tokenStorage.saveTokens(
        accessToken: data.accessToken,
        refreshToken: data.refreshToken,
        user: data.user,
      );
      return data.user;
    } on CustomException catch (e) {
      throw mapExceptionToFailure(e);
    } catch (e) {
      throw UnexpectedFailure();
    }
  }
}
