import 'package:flutter/material.dart';
import 'package:shinobi_desk/core/theme/app_colors.dart';
import 'package:shinobi_desk/core/theme/app_text_styles.dart';
import 'package:shinobi_desk/core/widgets/app_bottom_nav_bar.dart';
import 'package:shinobi_desk/core/widgets/character_avatar.dart';
import 'package:shinobi_desk/features/auth/presentation/screens/login_screen.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/home_screen.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/search_screen.dart';
import 'package:shinobi_desk/features/favorite/presentation/screens/favorites_screen.dart';
import 'package:shinobi_desk/features/profile/presentation/screens/settings_screen.dart';

/// Onglet "Profil". Le nom/email affichés sont en dur ; à remplacer par les
/// infos du user Supabase une fois l'auth branchée.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _goToTab(BuildContext context, int index) {
    if (index == 3) return;
    late final Widget page;
    switch (index) {
      case 0:
        page = const HomeScreen();
        break;
      case 1:
        page = const SearchScreen();
        break;
      default:
        page = const FavoritesScreen();
    }
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil', style: AppTextStyles.h3)),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              const CharacterAvatar(name: 'Will KANA', radius: 32),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Will KANA', style: AppTextStyles.h3),
                  Text(
                    'kanamboma@gmail.com',
                    style: AppTextStyles.bodySecondary,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(),
          _ProfileTile(
            icon: Icons.favorite_border_rounded,
            label: 'Mes favoris',
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const FavoritesScreen())),
          ),
          _ProfileTile(
            icon: Icons.settings_outlined,
            label: 'Paramètres',
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const SettingsPage())),
          ),
          _ProfileTile(
            icon: Icons.help_outline_rounded,
            label: 'Aide & support',
            onTap: () {},
          ),
          const Divider(),
          const SizedBox(height: 8),
          _ProfileTile(
            icon: Icons.logout_rounded,
            label: 'Se déconnecter',
            color: AppColors.error,
            onTap: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 3,
        onTap: (i) => _goToTab(context, i),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color ?? AppColors.textSecondary),
      title: Text(
        label,
        style: AppTextStyles.body.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: color ?? AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }
}
