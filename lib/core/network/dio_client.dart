import 'package:dio/dio.dart';
import 'package:shinobi_desk/core/constant/api_constants.dart';
import 'package:shinobi_desk/core/error/exception.dart';

Dio createDioClient() {
  return Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );
}

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
