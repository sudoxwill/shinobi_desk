import 'package:flutter/material.dart';
import 'package:shinobi_desk/core/screens/dev_screens_menu_page.dart';
import 'package:shinobi_desk/core/theme/app_theme.dart';

/// Point d'entrée de l'app.
///
/// `home` pointe pour l'instant vers [DevScreensMenuPage] pour prévisualiser
/// tous les écrans statiques générés d'un coup. Une fois que tu commences à
/// brancher la vraie logique (Riverpod, auth Supabase...), remplace `home:`
/// par `SplashPage()` pour repartir sur le vrai parcours : Splash -> Login
/// -> Accueil -> ...
///
/// `ProviderScope` n'est pas encore ajouté ici : ajoute-le quand tu
/// commenceras à faire consommer `charactersProvider` (ou les autres) par un
/// écran réel, sinon `ref.watch`/`ref.read` plantera au runtime faute de
/// conteneur Riverpod disponible.
void main() {
  runApp(const ShinobiDexApp());
}

class ShinobiDexApp extends StatelessWidget {
  const ShinobiDexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShinobiDex',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const DevScreensMenuPage(),
    );
  }
}
