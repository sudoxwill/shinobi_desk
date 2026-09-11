import 'package:flutter/material.dart';
import 'package:shinobi_desk/core/mock/mock_characters.dart';
import 'package:shinobi_desk/core/theme/app_text_styles.dart';
import 'package:shinobi_desk/core/widgets/app_bottom_nav_bar.dart';
import 'package:shinobi_desk/core/widgets/character_list_tile.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/character_detail_page.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/home_page.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/search_page.dart';
import 'package:shinobi_desk/features/profile/presentation/pages/profile_page.dart';

/// Onglet "Favoris".
///
/// Statique pour l'instant : affiche `mockCharacters` avec un cœur plein.
/// Rappel du plan posé plus tôt dans le projet — les favoris seront
/// synchronisés via une table Supabase (pas seulement du cache local), donc
/// cet écran finira branché sur un futur `favoritesProvider` qui appelle
/// Supabase, pas sur `charactersProvider`.
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  void _goToTab(BuildContext context, int index) {
    if (index == 2) return;
    late final Widget page;
    switch (index) {
      case 0:
        page = const HomePage();
        break;
      case 1:
        page = const SearchPage();
        break;
      default:
        page = const ProfilePage();
    }
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final favorites = mockCharacters.take(8).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mes favoris (${favorites.length})',
          style: AppTextStyles.h3,
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: favorites.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final character = favorites[index];
          return CharacterListTile(
            character: character,
            trailing: const Icon(
              Icons.favorite_rounded,
              color: Colors.redAccent,
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CharacterDetailPage(character: character),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 2,
        onTap: (i) => _goToTab(context, i),
      ),
    );
  }
}
