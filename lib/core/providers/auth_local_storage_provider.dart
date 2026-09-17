import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shinobi_desk/core/network/auth_local_storage.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final authLocalStorageProvider = Provider<AuthLocalStorage>((ref) {
  return AuthLocalStorageImpl(ref.watch(secureStorageProvider));
});
