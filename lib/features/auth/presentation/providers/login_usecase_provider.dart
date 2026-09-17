import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/features/auth/domain/usecases/login_usecase.dart';
import 'package:shinobi_desk/features/auth/presentation/providers/auth_repository_provider.dart';

final loginUseCaseProvider = Provider<LoginUsecase>((ref) {
  return LoginUsecase(ref.watch(authRepositoryProvider));
});
