sealed class CustomException implements Exception {
  final String? message;
  const CustomException({this.message});

  @override
  String toString() {
    return message.toString();
  }
}

class NetworkException extends CustomException {
  const NetworkException({super.message});
}

class ServerException extends CustomException {
  const ServerException({super.message});
}

class NotFoundException extends CustomException {
  const NotFoundException({super.message});
}

class CacheException extends CustomException {
  const CacheException({super.message});
}

class AuthException extends CustomException {
  const AuthException({super.message});
}
