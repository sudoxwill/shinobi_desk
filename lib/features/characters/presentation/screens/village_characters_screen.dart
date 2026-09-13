import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/core/theme/app_text_styles.dart';
import 'package:shinobi_desk/core/widgets/character_list_tile.dart';
import 'package:shinobi_desk/core/widgets/village_data.dart';
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
  void dispose() {
    ref.invalidate(charactersByVillageProvider(widget.village.label));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final charactersByVillageAsync = ref.watch(
      charactersByVillageProvider(widget.village.label),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.village.color,
        foregroundColor: Colors.white,
        title: Text(widget.village.label),
      ),
      body: charactersByVillageAsync.isLoading
          ? Center(child: CircularProgressIndicator())
          : charactersByVillageAsync.value == null
          ? Center(
              child: Text(
                'Aucun personnage trouvé pour ${widget.village.label}.',
                style: AppTextStyles.bodySecondary,
              ),
            )
          : charactersByVillageAsync.value!.isEmpty
          ? Center(
              child: Text(
                'Aucun personnage trouvé pour ${widget.village.label}.',
                style: AppTextStyles.bodySecondary,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: charactersByVillageAsync.value!.length,
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
