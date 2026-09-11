import 'package:flutter/material.dart';
import 'package:shinobi_desk/core/theme/app_colors.dart';
import 'package:shinobi_desk/core/widgets/app_text_field.dart';
import 'package:shinobi_desk/core/widgets/primary_button.dart';
import 'package:shinobi_desk/features/auth/presentation/pages/register_page.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/home_page.dart';

/// Écran de connexion. Purement visuel pour l'instant : les champs ne sont
/// reliés à aucune logique d'authentification, et "Se connecter" navigue
/// directement vers l'accueil. À brancher plus tard sur le futur
/// AuthNotifier (Supabase Auth).
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              PrimaryButton(
                label: 'Se connecter',
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RegisterPage()),
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
