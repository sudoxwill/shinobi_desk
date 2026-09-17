import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/core/network/auth_interceptor.dart';
import 'package:shinobi_desk/core/network/dio_client.dart';
import 'package:shinobi_desk/core/providers/auth_local_storage_provider.dart';

final refreshDioProvider = Provider<Dio>((ref) => createSupabaseDioClient());

final authInterceptorProvider = Provider<AuthInterceptor>((ref) {
  return AuthInterceptor(
    tokenStorage: ref.watch(
      authLocalStorageProvider,
    ), // à créer si pas déjà fait
    dio: ref.watch(refreshDioProvider),
  );
});

final supabaseDioProvider = Provider<Dio>((ref) {
  final dio = createSupabaseDioClient();
  dio.interceptors.add(ref.watch(authInterceptorProvider));
  return dio;
});
