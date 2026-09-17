import 'package:dio/dio.dart';
import 'package:shinobi_desk/core/error/exception.dart';

CustomException mapDioException(DioException e) {
  final dioExceptionType = e.type;
  return switch (dioExceptionType) {
    DioExceptionType.connectionTimeout => NetworkException(),
    DioExceptionType.sendTimeout => NetworkException(),
    DioExceptionType.receiveTimeout => NetworkException(),
    DioExceptionType.badCertificate => NetworkException(),
    DioExceptionType.badResponse =>
      e.response?.statusCode == 404 ? NotFoundException() : ServerException(),
    DioExceptionType.cancel => ServerException(),
    DioExceptionType.connectionError => NetworkException(),
    DioExceptionType.unknown => ServerException(),
    DioExceptionType.transformTimeout => NetworkException(),
  };
}

CustomException mapAuthDioException(DioException e) {
  // Timeout, pas de connexion, etc. : inutile de chercher un message Supabase.
  if (e.type != DioExceptionType.badResponse) {
    return NetworkException();
  }

  final data = e.response?.data;
  String? message;
  if (data is Map<String, dynamic>) {
    message = data['msg'];
  }

  return AuthException(message: message ?? 'Une erreur est survenue.');
}
