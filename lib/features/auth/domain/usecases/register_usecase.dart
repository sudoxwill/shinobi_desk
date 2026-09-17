import 'package:equatable/equatable.dart';
import 'package:shinobi_desk/core/usecase/usecase.dart';
import 'package:shinobi_desk/features/auth/domain/entities/app_user.dart';
import 'package:shinobi_desk/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase extends Usecase<AppUser, RegisterParams> {
  final AuthRepository authRepository;

  RegisterUsecase(this.authRepository);

  @override
  Future<AppUser> call(RegisterParams param) async {
    return await authRepository.register(
      email: param.email,
      password: param.password,
    );
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String password;

  const RegisterParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
