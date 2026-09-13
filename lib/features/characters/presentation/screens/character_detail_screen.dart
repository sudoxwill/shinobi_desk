import 'package:flutter/material.dart';
import 'package:shinobi_desk/core/theme/app_colors.dart';
import 'package:shinobi_desk/core/theme/app_text_styles.dart';
import 'package:shinobi_desk/core/widgets/character_avatar.dart';
import 'package:shinobi_desk/core/widgets/info_row.dart';
import 'package:shinobi_desk/core/widgets/primary_button.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';

/// Fiche détaillée d'un personnage
class CharacterDetailScreen extends StatefulWidget {
  const CharacterDetailScreen({super.key, required this.character});

  final Character character;

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final character = widget.character;
    final village = character.affiliation!.isNotEmpty
        ? character.affiliation!.first
        : '—';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.dark,
            leading: IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.black38,
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  icon: CircleAvatar(
                    backgroundColor: Colors.black38,
                    child: Icon(
                      _isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: _isFavorite ? AppColors.primary : Colors.white,
                      size: 20,
                    ),
                  ),
                  onPressed: () => setState(() => _isFavorite = !_isFavorite),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF2A2A3A), AppColors.dark],
                  ),
                ),
                child: Center(
                  child: CharacterAvatar(
                    name: character.name,
                    imageUrl: character.images.isNotEmpty
                        ? character.images.first
                        : null,
                    radius: 64,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(character.name, style: AppTextStyles.h2),
                  const SizedBox(height: 4),
                  Text(village, style: AppTextStyles.bodySecondary),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: [
                      if (character.clan != null) _Tag(character.clan!),
                      if (character.sex != null) _Tag(character.sex!),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  InfoRow(
                    icon: Icons.location_on_outlined,
                    label: 'Village',
                    value: village,
                  ),
                  // InfoRow(
                  //   icon: Icons.bolt_outlined,
                  //   label: 'Nature de chakra',
                  //   value: character.natureType!.isNotEmpty
                  //       ? character.natureType!.join(', ')
                  //       : '—',
                  // ),
                  InfoRow(
                    icon: Icons.cake_outlined,
                    label: 'Anniversaire',
                    value: character.birthdate ?? '—',
                  ),
                  InfoRow(
                    icon: Icons.groups_outlined,
                    label: 'Clan',
                    value: character.clan ?? '—',
                  ),
                  if (character.natureType!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text('Nature de chakra', style: AppTextStyles.h3),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final natureType in character.natureType!)
                          _Tag(natureType),
                      ],
                    ),
                  ],
                  const SizedBox(height: 28),
                  if (character.jutsu!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text('Jutsu', style: AppTextStyles.h3),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final jutsu in character.jutsu!) _Tag(jutsu),
                      ],
                    ),
                  ],

                  const SizedBox(height: 28),
                  PrimaryButton(
                    label: _isFavorite
                        ? 'Retirer des favoris'
                        : 'Ajouter aux favoris',
                    icon: _isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    onPressed: () => setState(() => _isFavorite = !_isFavorite),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
      ),
    );
  }
}
