import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/core/providers/auth_local_storage_provider.dart';
import 'package:shinobi_desk/features/auth/domain/entities/app_user.dart';
import 'package:shinobi_desk/features/auth/domain/usecases/login_usecase.dart';
import 'package:shinobi_desk/features/auth/domain/usecases/logout_usecase.dart';
import 'package:shinobi_desk/features/auth/domain/usecases/register_usecase.dart';
import 'package:shinobi_desk/features/auth/presentation/providers/login_usecase_provider.dart';
import 'package:shinobi_desk/features/auth/presentation/providers/logout_usecase_provider.dart';
import 'package:shinobi_desk/features/auth/presentation/providers/register_usecase_provider.dart';

class AuthNotifier extends AsyncNotifier<AppUser?> {
  @override
  FutureOr<AppUser?> build() async {
    final authLocalStorage = ref.read(authLocalStorageProvider);
    final token = await authLocalStorage.getAccessToken();
    if (token == null) return null;
    return await authLocalStorage.getUser();
  }

  Future<void> login(String email, String password) async {
    state = AsyncValue.loading();
    final usecase = ref.read(loginUseCaseProvider);
    state = await AsyncValue.guard(() async {
      return await usecase(LoginParams(email: email, password: password));
    });
  }

  Future<void> register(String email, String password) async {
    state = AsyncValue.loading();
    final usecase = ref.read(registerUseCaseProvider);
    state = await AsyncValue.guard(() async {
      return await usecase(RegisterParams(email: email, password: password));
    });
  }

  Future<void> logout() async {
    state = AsyncValue.loading();
    final usecase = ref.read(logoutUseCaseProvider);
    state = await AsyncValue.guard(() async {
      await usecase(LogoutParams());
      return null;
    });
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, AppUser?>(
  AuthNotifier.new,
);
