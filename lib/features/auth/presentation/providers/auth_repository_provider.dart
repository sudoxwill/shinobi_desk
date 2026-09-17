import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/core/providers/auth_local_storage_provider.dart';
import 'package:shinobi_desk/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:shinobi_desk/features/auth/domain/repositories/auth_repository.dart';
import 'package:shinobi_desk/features/auth/presentation/providers/auth_remote_data_source_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    authRemoteDataSource: ref.watch(authRemoteDataSourceProvider),
    tokenStorage: ref.watch(authLocalStorageProvider),
  );
});
