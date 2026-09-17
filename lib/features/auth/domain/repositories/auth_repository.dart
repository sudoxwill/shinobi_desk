import 'package:shinobi_desk/features/auth/domain/entities/app_user.dart';

abstract class AuthRepository {
  Future<AppUser> login({required String email, required String password});
  Future<AppUser> register({required String email, required String password});
  Future<void> logout();
}
