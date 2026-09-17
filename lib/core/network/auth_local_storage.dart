import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shinobi_desk/features/auth/domain/entities/app_user.dart';

abstract class AuthLocalStorage {
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required AppUser user,
  });
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearTokens();
  Future<AppUser?> getUser();
}

class AuthLocalStorageImpl implements AuthLocalStorage {
  final FlutterSecureStorage secureStorage;
  AuthLocalStorageImpl(this.secureStorage);

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userKey = 'auth_user';

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required AppUser user,
  }) async {
    await secureStorage.write(key: _accessTokenKey, value: accessToken);
    await secureStorage.write(key: _refreshTokenKey, value: refreshToken);
    await secureStorage.write(
      key: _userKey,
      value: jsonEncode({'id': user.id, 'email': user.email}),
    );
  }

  @override
  Future<String?> getAccessToken() => secureStorage.read(key: _accessTokenKey);

  @override
  Future<String?> getRefreshToken() =>
      secureStorage.read(key: _refreshTokenKey);

  @override
  Future<void> clearTokens() async {
    await secureStorage.delete(key: _accessTokenKey);
    await secureStorage.delete(key: _refreshTokenKey);
    await secureStorage.delete(key: _userKey);
  }

  @override
  Future<AppUser?> getUser() async {
    final raw = await secureStorage.read(key: _userKey);
    if (raw == null) return null;
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return AppUser(id: json['id'], email: json['email']);
  }
}
