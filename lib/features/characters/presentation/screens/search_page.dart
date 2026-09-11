import 'package:flutter/material.dart';
import 'package:shinobi_desk/core/mock/mock_characters.dart';
import 'package:shinobi_desk/core/theme/app_text_styles.dart';
import 'package:shinobi_desk/core/widgets/app_bottom_nav_bar.dart';
import 'package:shinobi_desk/core/widgets/app_text_field.dart';
import 'package:shinobi_desk/core/widgets/character_list_tile.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/character_detail_page.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/home_page.dart';
import 'package:shinobi_desk/features/favorite/presentation/pages/favorites_page.dart';
import 'package:shinobi_desk/features/profile/presentation/pages/profile_page.dart';

/// Onglet "Explorer" / recherche.
///
/// Le filtre ci-dessous tourne en local sur `mockCharacters` (simple
/// `where` sur le nom) juste pour que l'écran ait un comportement visible.
/// Ce n'est PAS le vrai `searchProvider` / `SearchCharactersNotifier` que tu
/// as construit — à remplacer quand tu branches cet écran pour de vrai
/// (recherche côté API via `?name=`, gestion loading/error, etc.).
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToTab(int index) {
    if (index == 1) return;
    late final Widget page;
    switch (index) {
      case 0:
        page = const HomePage();
        break;
      case 2:
        page = const FavoritesPage();
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
    final List<Character> results = _query.isEmpty
        ? const []
        : mockCharacters
              .where((c) => c.name.toLowerCase().contains(_query.toLowerCase()))
              .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Rechercher', style: AppTextStyles.h3)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 8),
            AppTextField(
              hint: 'Rechercher un personnage...',
              controller: _controller,
              icon: Icons.search_rounded,
              onChanged: (value) => setState(() => _query = value),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _query.isEmpty
                  ? const Center(
                      child: Text(
                        'Tape un nom pour commencer ta recherche.',
                        style: AppTextStyles.bodySecondary,
                      ),
                    )
                  : results.isEmpty
                  ? const Center(
                      child: Text(
                        'Aucun personnage trouvé.',
                        style: AppTextStyles.bodySecondary,
                      ),
                    )
                  : ListView.separated(
                      itemCount: results.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final character = results[index];
                        return CharacterListTile(
                          character: character,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  CharacterDetailPage(character: character),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(currentIndex: 1, onTap: _goToTab),
    );
  }
}
