import 'package:flutter/material.dart';
import 'package:shinobi_desk/core/mock/mock_characters.dart';
import 'package:shinobi_desk/core/theme/app_text_styles.dart';
import 'package:shinobi_desk/core/widgets/app_text_field.dart';
import 'package:shinobi_desk/core/widgets/character_list_tile.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/character_detail_page.dart';

/// Liste des personnages ("Voir tout" depuis l'accueil).
///
/// C'EST L'ÉCRAN À BRANCHER TOI-MÊME sur `charactersProvider` /
/// `CharactersNotifier`. Pour l'instant il affiche `mockCharacters` en dur,
/// et le champ de recherche ne filtre rien.
///
/// Pistes pour le branchement (à faire dans une prochaine étape) :
/// - passer de `StatelessWidget` à `ConsumerWidget`
/// - remplacer `mockCharacters` par `ref.watch(charactersProvider)`
///   (un `AsyncValue<List<Character>>`)
/// - utiliser `.when(data: ..., loading: ..., error: ...)` pour décider quoi
///   afficher à la place de la `ListView.separated` ci-dessous
class CharactersListPage extends StatelessWidget {
  const CharactersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personnages', style: AppTextStyles.h3)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 8),
            const AppTextField(
              hint: 'Rechercher un personnage...',
              icon: Icons.search_rounded,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: mockCharacters.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final character = mockCharacters[index];
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
    );
  }
}
