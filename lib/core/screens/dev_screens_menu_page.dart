import 'package:flutter/material.dart';
import 'package:shinobi_desk/core/mock/mock_characters.dart';
import 'package:shinobi_desk/core/screens/network_error_page.dart';
import 'package:shinobi_desk/core/screens/offline_page.dart';
import 'package:shinobi_desk/core/screens/splash_page.dart';
import 'package:shinobi_desk/features/auth/presentation/pages/login_page.dart';
import 'package:shinobi_desk/features/auth/presentation/pages/register_page.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/character_detail_page.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/characters_list_page.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/home_page.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/search_page.dart';
import 'package:shinobi_desk/features/favorite/presentation/pages/favorites_page.dart';
import 'package:shinobi_desk/features/profile/presentation/pages/profile_page.dart';
import 'package:shinobi_desk/features/profile/presentation/pages/settings_page.dart';

/// Menu de dev listant tous les écrans générés, pour les prévisualiser
/// rapidement sans suivre le vrai parcours de navigation.
///
/// C'est un écran temporaire : une fois que tu commences à brancher la vraie
/// logique (auth, providers...), remplace `home:` dans main.dart par
/// `SplashPage()` pour repartir sur le vrai parcours utilisateur, et
/// supprime ce fichier (ou garde-le en debug, à toi de voir).
class DevScreensMenuPage extends StatelessWidget {
  const DevScreensMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = <String, WidgetBuilder>{
      'Splash': (_) => const SplashPage(),
      'Connexion': (_) => const LoginPage(),
      'Inscription': (_) => const RegisterPage(),
      'Accueil': (_) => const HomePage(),
      'Personnages (liste)': (_) => const CharactersListPage(),
      'Fiche personnage': (_) =>
          CharacterDetailPage(character: mockCharacters.first),
      'Favoris': (_) => const FavoritesPage(),
      'Recherche': (_) => const SearchPage(),
      'Mode hors-ligne': (_) => const OfflinePage(),
      'Erreur réseau': (_) => const NetworkErrorPage(),
      // 'Catégories': (_) => const CategoriesPage(),
      'Profil': (_) => const ProfilePage(),
      'Paramètres': (_) => const SettingsPage(),
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Écrans (dev)')),
      body: ListView(
        children: [
          for (final entry in entries.entries)
            ListTile(
              title: Text(entry.key),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: entry.value)),
            ),
        ],
      ),
    );
  }
}

class CategoriesPage {
  const CategoriesPage();
}
