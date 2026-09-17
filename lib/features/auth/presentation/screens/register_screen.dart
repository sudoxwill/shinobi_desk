import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/core/error/failure.dart';
import 'package:shinobi_desk/core/theme/app_colors.dart';
import 'package:shinobi_desk/core/widgets/app_text_field.dart';
import 'package:shinobi_desk/core/widgets/primary_button.dart';
import 'package:shinobi_desk/features/auth/domain/entities/app_user.dart';
import 'package:shinobi_desk/features/auth/presentation/providers/auth_provider.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/home_screen.dart';

/// Écran de création de compte
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String _errorMessage(Object error) {
    if (error is AuthFailure) {
      return error.message ?? 'Impossible de créer le compte.';
    }
    if (error is NetworkFailure) return 'Pas de connexion internet.';
    return 'Une erreur est survenue, réessaie plus tard.';
  }

  void _submit() {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Les mots de passe ne correspondent pas.'),
        ),
      );
      return;
    }
    ref
        .read(authProvider.notifier)
        .register(_emailController.text.trim(), _passwordController.text);
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
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Créer un compte',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Rejoins la communauté des shinobi !',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              // const SizedBox(height: 28),
              // AppTextField(
              //   hint: "Nom d'utilisateur",
              //   controller: _usernameController,
              //   icon: Icons.person_outline_rounded,
              //   filled: false,
              // ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              AppTextField(
                hint: 'Confirmer le mot de passe',
                controller: _confirmPasswordController,
                icon: Icons.lock_outline_rounded,
                obscureToggle: true,
                filled: false,
              ),
              const SizedBox(height: 28),
              authState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : PrimaryButton(label: "S'inscrire", onPressed: _submit),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text.rich(
                    TextSpan(
                      text: 'Déjà un compte ? ',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 13,
                      ),
                      children: const [
                        TextSpan(
                          text: 'Se connecter',
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
