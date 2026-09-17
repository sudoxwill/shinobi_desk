import 'package:shinobi_desk/core/error/exception.dart';
import 'package:shinobi_desk/core/error/failure.dart';

Failure mapExceptionToFailure(CustomException e) {
  return switch (e) {
    NetworkException() => NetworkFailure(),

    ServerException() => ServerFailure(),

    NotFoundException() => NotFoundFailure(),

    CacheException() => CacheFailure(),
    AuthException() => AuthFailure(message: e.message),
  };
}
