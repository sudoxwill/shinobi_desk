import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Couleurs de marque
  static const Color primary = Color(0xFFF2751A); // orange Konoha
  static const Color primaryDark = Color(0xFFD9600C);

  // Fonds
  static const Color background = Color(0xFFFAF7F2); // fond clair (crème)
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFF3EFE8);
  static const Color dark = Color(
    0xFF15151F,
  ); // fond sombre (login, offline...)
  static const Color darkSurface = Color(0xFF1E1E2A);

  // Textes
  static const Color textPrimary = Color(0xFF1B1B23);
  static const Color textSecondary = Color(0xFF8A8A93);
  static const Color textOnDark = Color(0xFFF5F3EF);
  static const Color textOnDarkSecondary = Color(0xFFAFAFB8);

  // États / feedback
  static const Color error = Color(0xFFE0473E);
  static const Color errorBackground = Color(0xFFFCEAE9);
  static const Color success = Color(0xFF4CAF7D);

  // Catégories de villages (utilisées pour les chips/cartes de catégories)
  static const Color konoha = Color(0xFF5FAE82);
  static const Color suna = Color(0xFFD8C9A3);
  static const Color kiri = Color(0xFFAEE0F0);
  static const Color kumo = Color(0xFFF4D35E);
  static const Color iwa = Color(0xFF9C9284);
  static const Color ame = Color(0xFF34495E);

  static const Color divider = Color(0xFFE7E2D9);
}
