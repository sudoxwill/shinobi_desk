import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/core/providers/dio_supabase_provider.dart';
import 'package:shinobi_desk/features/auth/data/datasources/auth_remote_data_source.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(ref.watch(supabaseDioProvider));
});
