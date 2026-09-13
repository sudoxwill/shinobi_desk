import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/core/screens/network_error_screen.dart';
import 'package:shinobi_desk/core/theme/app_colors.dart';
import 'package:shinobi_desk/core/theme/app_text_styles.dart';
import 'package:shinobi_desk/core/widgets/app_bottom_nav_bar.dart';
import 'package:shinobi_desk/core/widgets/character_avatar.dart';
import 'package:shinobi_desk/core/widgets/featured_character_card.dart';
import 'package:shinobi_desk/core/widgets/section_header.dart';
import 'package:shinobi_desk/core/widgets/village_category_card.dart';
import 'package:shinobi_desk/core/widgets/village_data.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/character_provider.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/characters_provider.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/character_detail_screen.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/search_screen.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/village_characters_screen.dart';
import 'package:shinobi_desk/features/favorite/presentation/screens/favorites_screen.dart';
import 'package:shinobi_desk/features/profile/presentation/screens/profile_screen.dart';

/// Écran d'accueil
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _goToTab(BuildContext context, int index) {
    if (index == 0) return;
    late final Widget page;
    switch (index) {
      case 1:
        page = const SearchScreen();
        break;
      case 2:
        page = const FavoritesScreen();
        break;
      default:
        page = const ProfileScreen();
    }
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  void _openDetail(BuildContext context, Character character) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CharacterDetailScreen(character: character),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularCharactersAsync = ref.watch(charactersProvider);
    final featuredCharactersAsync = ref.watch(characterProvider);

    ref.listen<AsyncValue<Character>>(characterProvider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => NetworkErrorScreen(
              onRetry: () {
                Navigator.of(context).pop();
                ref.invalidate(characterProvider);
              },
            ),
          ),
        );
      }
    });

    ref.listen<AsyncValue<List<Character>>>(charactersProvider, (
      previous,
      next,
    ) {
      if (next.hasError && !next.isLoading) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => NetworkErrorScreen(
              onRetry: () {
                Navigator.of(context).pop();
                ref.invalidate(charactersProvider);
              },
            ),
          ),
        );
      }
    });

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
      body:
          popularCharactersAsync.isLoading || featuredCharactersAsync.isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                  const SizedBox(height: 12),
                  FeaturedCharacterCard(
                    character: featuredCharactersAsync.value!,
                  ),
                  const SizedBox(height: 24),
                  SectionHeader(title: 'Catégories', onSeeAll: () {}),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.2,
                    children: [
                      for (final village in VillageData.all)
                        VillageCategoryCard(
                          label: village.label,
                          color: village.color,
                          icon: village.icon,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  VillageCharactersScreen(village: village),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  SectionHeader(
                    title: 'Personnages populaires',
                    onSeeAll: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SearchScreen()),
                    ),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 150,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: popularCharactersAsync.value!.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        final character = popularCharactersAsync.value![index];
                        return GestureDetector(
                          onTap: () => _openDetail(context, character),
                          child: SizedBox(
                            width: 96,
                            child: Column(
                              children: [
                                CharacterAvatar(
                                  name: character.name,
                                  imageUrl: character.images.isNotEmpty
                                      ? character.images.first
                                      : null,
                                  radius: 40,
                                ),
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
                                  character.affiliation.isNotEmpty
                                      ? character.affiliation.first
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
