import 'package:flutter/material.dart';
import 'package:shinobi_desk/core/constant/assets_constants.dart';
import 'package:shinobi_desk/core/widgets/primary_button.dart';
import 'package:shinobi_desk/features/auth/presentation/screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsConstants.spashBackgroundImage),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF2751A), Color(0xFF7A2E12), Color(0xFF15151F)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                const Spacer(flex: 1),
                Image.asset(
                  AssetsConstants.logo,
                  width: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                const Text(
                  'ShinobiDex',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Explore le monde des shinobi',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
                const Spacer(flex: 4),
                PrimaryButton(
                  label: 'Commencer',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
