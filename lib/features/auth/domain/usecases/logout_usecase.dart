import 'package:shinobi_desk/core/usecase/usecase.dart';
import 'package:shinobi_desk/features/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase extends Usecase<void, LogoutParams> {
  final AuthRepository authRepository;

  LogoutUsecase(this.authRepository);

  @override
  Future<void> call(LogoutParams param) async {
    return await authRepository.logout();
  }
}

class LogoutParams {}
