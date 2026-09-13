import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/core/screens/splash_screen.dart';
import 'package:shinobi_desk/core/theme/app_theme.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/home_screen.dart';

void main() {
  runApp(ProviderScope(child: const ShinobiDexApp()));
}

class ShinobiDexApp extends StatelessWidget {
  const ShinobiDexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShinobiDex',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}
