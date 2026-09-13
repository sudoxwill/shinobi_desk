import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/core/constant/api_constants.dart';
import 'package:shinobi_desk/core/theme/app_text_styles.dart';
import 'package:shinobi_desk/core/widgets/app_bottom_nav_bar.dart';
import 'package:shinobi_desk/core/widgets/app_text_field.dart';
import 'package:shinobi_desk/core/widgets/character_list_tile.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/search_provider.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/character_detail_screen.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/home_screen.dart';
import 'package:shinobi_desk/features/favorite/presentation/screens/favorites_screen.dart';
import 'package:shinobi_desk/features/profile/presentation/screens/profile_screen.dart';

/// Onglet recherche
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  int pageNumber = 1;

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
        page = const HomeScreen();
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

  @override
  Widget build(BuildContext context) {
    final searchProviderAsync = ref.watch(searchProvider);

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
              onSubmitted: (value) => ref
                  .read(searchProvider.notifier)
                  .searchCharacters(
                    query: value,
                    page: pageNumber,
                    limit: ApiConstants.defaultLimit,
                  ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: searchProviderAsync.value == null
                  ? const Center(
                      child: Text(
                        'Tape un nom pour commencer ta recherche.',
                        style: AppTextStyles.bodySecondary,
                      ),
                    )
                  : searchProviderAsync.when(
                      data: (List<Character>? data) {
                        return data!.isEmpty
                            ? const Center(
                                child: Text(
                                  'Aucun personnage trouvé.',
                                  style: AppTextStyles.bodySecondary,
                                ),
                              )
                            : ListView.separated(
                                itemCount: data.length,
                                separatorBuilder: (_, _) =>
                                    const Divider(height: 1),
                                itemBuilder: (context, index) {
                                  final character = data[index];
                                  return CharacterListTile(
                                    character: character,
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => CharacterDetailScreen(
                                          character: character,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                      },
                      error: (Object error, StackTrace stackTrace) => Center(
                        child: Text(
                          error.toString(),
                          style: AppTextStyles.bodySecondary,
                        ),
                      ),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(currentIndex: 1, onTap: _goToTab),
    );
  }
}
