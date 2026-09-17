import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/core/error/failure.dart';
import 'package:shinobi_desk/core/theme/app_colors.dart';
import 'package:shinobi_desk/core/widgets/app_text_field.dart';
import 'package:shinobi_desk/core/widgets/primary_button.dart';
import 'package:shinobi_desk/features/auth/domain/entities/app_user.dart';
import 'package:shinobi_desk/features/auth/presentation/providers/auth_provider.dart';
import 'package:shinobi_desk/features/auth/presentation/screens/register_screen.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/home_screen.dart';

/// Écran de connexion
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _errorMessage(Object error) {
    if (error is AuthFailure) {
      return error.message ?? 'Email ou mot de passe incorrect.';
    }
    if (error is NetworkFailure) {
      return 'Pas de connexion internet.';
    }
    return 'Une erreur est survenue, réessaie plus tard.';
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    ref.listen<AsyncValue<AppUser?>>(authProvider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_errorMessage(next.error!))));
      }
      if (next.hasValue && next.value != null && !next.isLoading) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.dark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Icon(
                Icons.filter_vintage_rounded,
                color: AppColors.primary,
                size: 32,
              ),
              const SizedBox(height: 32),
              const Text(
                'Bon retour ! 👋',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Connecte-toi pour continuer',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 32),
              AppTextField(
                hint: 'Email',
                controller: _emailController,
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                filled: false,
              ),
              const SizedBox(height: 16),
              AppTextField(
                hint: 'Mot de passe',
                controller: _passwordController,
                icon: Icons.lock_outline_rounded,
                obscureToggle: true,
                filled: false,
              ),
              const SizedBox(height: 28),
              authState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : PrimaryButton(
                      label: 'Se connecter',
                      onPressed: () {
                        ref
                            .read(authProvider.notifier)
                            .login(
                              _emailController.text.trim(),
                              _passwordController.text,
                            );
                      },
                    ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Pas encore de compte ? ",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 13,
                      ),
                      children: const [
                        TextSpan(
                          text: "S'inscrire",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
