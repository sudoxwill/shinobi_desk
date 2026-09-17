import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/features/auth/domain/usecases/register_usecase.dart';
import 'package:shinobi_desk/features/auth/presentation/providers/auth_repository_provider.dart';

final registerUseCaseProvider = Provider<RegisterUsecase>((ref) {
  return RegisterUsecase(ref.watch(authRepositoryProvider));
});
