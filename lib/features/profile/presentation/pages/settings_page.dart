import 'package:flutter/material.dart';
import 'package:shinobi_desk/core/theme/app_colors.dart';
import 'package:shinobi_desk/core/theme/app_text_styles.dart';
import 'package:shinobi_desk/features/auth/presentation/pages/login_page.dart';

/// Écran Paramètres. Uniquement visuel : le sélecteur de thème n'a pas
/// d'effet réel (pas de vrai dark mode branché pour l'instant).
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres', style: AppTextStyles.h3)),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const _SectionLabel('Compte'),
          const _SettingsTile(icon: Icons.person_outline_rounded, label: 'Modifier le profil'),
          const _SettingsTile(icon: Icons.lock_outline_rounded, label: 'Changer le mot de passe'),
          const SizedBox(height: 16),
          const _SectionLabel('Préférences'),
          const _SettingsTile(icon: Icons.palette_outlined, label: 'Thème', value: 'Système'),
          const SizedBox(height: 16),
          const _SectionLabel('Autres'),
          const _SettingsTile(icon: Icons.info_outline_rounded, label: 'À propos'),
          _SettingsTile(
            icon: Icons.logout_rounded,
            label: 'Déconnexion',
            color: AppColors.error,
            onTap: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(label.toUpperCase(), style: AppTextStyles.caption.copyWith(letterSpacing: 0.6)),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.icon, required this.label, this.value, this.color, this.onTap});

  final IconData icon;
  final String label;
  final String? value;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color ?? AppColors.textSecondary),
      title: Text(label, style: AppTextStyles.body.copyWith(color: color, fontWeight: FontWeight.w600)),
      trailing: value != null
          ? Text(value!, style: AppTextStyles.bodySecondary)
          : Icon(Icons.chevron_right, color: color ?? AppColors.textSecondary),
      onTap: onTap ?? () {},
    );
  }
}
