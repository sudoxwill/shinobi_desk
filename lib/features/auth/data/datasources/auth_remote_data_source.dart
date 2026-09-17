import 'package:dio/dio.dart';
import 'package:shinobi_desk/core/constant/supabase_constants.dart';
import 'package:shinobi_desk/core/error/exception_mapper.dart';
import 'package:shinobi_desk/features/auth/data/models/auth_session_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> register({
    required String email,
    required String password,
  });
  Future<AuthSessionModel> login({
    required String email,
    required String password,
  });

  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<AuthSessionModel> register({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        SupabaseConstants.signUpPath,
        data: {'email': email, 'password': password},
      );
      return AuthSessionModel.fromJson(response.data);
    } on DioException catch (e) {
      throw mapAuthDioException(e);
    }
  }

  @override
  Future<AuthSessionModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        SupabaseConstants.tokenPath,
        queryParameters: {'grant_type': 'password'},
        data: {'email': email, 'password': password},
      );
      return AuthSessionModel.fromJson(response.data);
    } on DioException catch (e) {
      throw mapAuthDioException(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dio.post(SupabaseConstants.logoutPath);
    } on DioException catch (e) {
      throw mapAuthDioException(e);
    }
  }
}
