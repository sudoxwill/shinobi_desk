import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shinobi_desk/core/constant/local_constants.dart';
import 'package:shinobi_desk/core/screens/splash_screen.dart';
import 'package:shinobi_desk/core/theme/app_theme.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<String>(LocalConstants.charactersBoxKey);
  await dotenv.load(fileName: '.env');
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
