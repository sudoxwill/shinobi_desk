import 'package:flutter/material.dart';
import 'package:shinobi_desk/core/theme/app_colors.dart';
import 'package:shinobi_desk/core/widgets/app_text_field.dart';
import 'package:shinobi_desk/core/widgets/primary_button.dart';

/// Écran de création de compte. Comme LoginPage, c'est du visuel seul : pas
/// de validation de formulaire ni d'appel à Supabase Auth pour l'instant.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  @override
  Widget build(BuildContext context) {
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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 6),
              Text(
                'Rejoins la communauté des shinobi !',
                style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.6)),
              ),
              const SizedBox(height: 28),
              AppTextField(
                hint: "Nom d'utilisateur",
                controller: _usernameController,
                icon: Icons.person_outline_rounded,
                filled: false,
              ),
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
              PrimaryButton(
                label: "S'inscrire",
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text.rich(
                    TextSpan(
                      text: 'Déjà un compte ? ',
                      style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13),
                      children: const [
                        TextSpan(
                          text: 'Se connecter',
                          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
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
