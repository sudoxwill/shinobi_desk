import 'package:flutter/material.dart';
import 'package:shinobi_desk/core/mock/mock_characters.dart';
import 'package:shinobi_desk/core/screens/dev_screens_menu_page.dart';
import 'package:shinobi_desk/core/theme/app_colors.dart';
import 'package:shinobi_desk/core/theme/app_text_styles.dart';
import 'package:shinobi_desk/core/widgets/app_bottom_nav_bar.dart';
import 'package:shinobi_desk/core/widgets/character_avatar.dart';
import 'package:shinobi_desk/core/widgets/section_header.dart';
import 'package:shinobi_desk/core/widgets/village_category_card.dart';
import 'package:shinobi_desk/core/widgets/village_data.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/character_detail_page.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/characters_list_page.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/search_page.dart';
import 'package:shinobi_desk/features/favorite/presentation/pages/favorites_page.dart';
import 'package:shinobi_desk/features/profile/presentation/pages/profile_page.dart';

/// Écran d'accueil. Purement statique : les catégories et la liste
/// "personnages populaires" viennent de `mockCharacters`, pas de
/// `charactersProvider`. C'est volontaire (cf. discussion) — le but ici est
/// juste de poser le visuel ; le branchement Riverpod, tu le fais toi-même.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _goToTab(BuildContext context, int index) {
    if (index == 0) return;
    late final Widget page;
    switch (index) {
      case 1:
        page = const SearchPage();
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

  void _openDetail(BuildContext context, Character character) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CharacterDetailPage(character: character),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final popularCharacters = mockCharacters.take(5).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ShinobiDex', style: AppTextStyles.h3),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () => _goToTab(context, 1),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => _goToTab(context, 3),
              child: const CharacterAvatar(name: 'Will', radius: 16),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _goToTab(context, 1),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.search_rounded,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Rechercher un personnage...',
                      style: AppTextStyles.bodySecondary,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SectionHeader(
              title: 'Catégories',
              onSeeAll: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => Center())),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                for (final village in VillageData.all)
                  VillageCategoryCard(
                    label: village.label,
                    color: village.color,
                    icon: village.icon,
                  ),
              ],
            ),
            const SizedBox(height: 28),
            SectionHeader(
              title: 'Personnages populaires',
              onSeeAll: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CharactersListPage()),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: popularCharacters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final character = popularCharacters[index];
                  return GestureDetector(
                    onTap: () => _openDetail(context, character),
                    child: SizedBox(
                      width: 96,
                      child: Column(
                        children: [
                          CharacterAvatar(name: character.name, radius: 40),
                          const SizedBox(height: 8),
                          Text(
                            character.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            character.affiliation!.isNotEmpty
                                ? character.affiliation!.first
                                : '—',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 0,
        onTap: (i) => _goToTab(context, i),
      ),
    );
  }
}
