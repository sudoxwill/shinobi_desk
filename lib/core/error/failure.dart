sealed class Failure {
  const Failure();
}

class NetworkFailure extends Failure {
  const NetworkFailure();
}

class ServerFailure extends Failure {
  const ServerFailure();
}

class NotFoundFailure extends Failure {
  const NotFoundFailure();
}

class CacheFailure extends Failure {
  const CacheFailure();
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure();
}

class AuthFailure extends Failure {
  final String? message;
  const AuthFailure({this.message});
}
