import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/features/auth/domain/usecases/logout_usecase.dart';
import 'package:shinobi_desk/features/auth/presentation/providers/auth_repository_provider.dart';

final logoutUseCaseProvider = Provider<LogoutUsecase>((ref) {
  return LogoutUsecase(ref.watch(authRepositoryProvider));
});
