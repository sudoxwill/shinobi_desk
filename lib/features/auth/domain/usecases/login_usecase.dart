import 'package:equatable/equatable.dart';
import 'package:shinobi_desk/core/usecase/usecase.dart';
import 'package:shinobi_desk/features/auth/domain/entities/app_user.dart';
import 'package:shinobi_desk/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase extends Usecase<AppUser, LoginParams> {
  final AuthRepository authRepository;

  LoginUsecase(this.authRepository);

  @override
  Future<AppUser> call(LoginParams param) async {
    return await authRepository.login(
      email: param.email,
      password: param.password,
    );
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
