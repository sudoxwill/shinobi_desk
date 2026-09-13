import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/core/screens/network_error_screen.dart';
import 'package:shinobi_desk/core/theme/app_text_styles.dart';
import 'package:shinobi_desk/core/widgets/character_list_tile.dart';
import 'package:shinobi_desk/core/widgets/village_data.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/characters_by_village_provider.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/character_detail_screen.dart';

class VillageCharactersScreen extends ConsumerStatefulWidget {
  const VillageCharactersScreen({super.key, required this.village});

  final VillageData village;

  @override
  ConsumerState<VillageCharactersScreen> createState() =>
      _VillageCharactersScreenState();
}

class _VillageCharactersScreenState
    extends ConsumerState<VillageCharactersScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(charactersByVillageProvider.notifier)
          .getCharactersByVillage(widget.village.label);
    });

    super.initState();
  }

  @override
  void dispose() {
    ref.invalidate(charactersByVillageProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final charactersByVillageAsync = ref.watch(charactersByVillageProvider);
    ref.listen<AsyncValue<List<Character>>>(charactersByVillageProvider, (
      previous,
      next,
    ) {
      if (next.hasError && !next.isLoading) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => NetworkErrorScreen(
              onRetry: () {
                Navigator.of(context).pop();
                ref.invalidate(charactersByVillageProvider);
              },
            ),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.village.color,
        foregroundColor: Colors.white,
        title: Text(widget.village.label),
      ),
      body: charactersByVillageAsync.isLoading
          ? Center(child: CircularProgressIndicator())
          : charactersByVillageAsync.value!.isEmpty
          ? Center(
              child: Text(
                'Aucun personnage trouvé pour ${widget.village.label}.',
                style: AppTextStyles.bodySecondary,
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: charactersByVillageAsync.value!.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final character = charactersByVillageAsync.value![index];
                return CharacterListTile(
                  character: character,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          CharacterDetailScreen(character: character),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
