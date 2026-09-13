import 'package:flutter/material.dart';
import 'package:shinobi_desk/core/theme/app_colors.dart';
import 'package:shinobi_desk/core/theme/app_text_styles.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/presentation/screens/character_detail_screen.dart';

/// Carte "Personnage à la une" pour l'accueil.
class FeaturedCharacterCard extends StatelessWidget {
  const FeaturedCharacterCard({
    super.key,
    required this.character,
    this.tagline,
    this.onSeeDetail,
  });

  final Character character;
  final String? tagline;
  final VoidCallback? onSeeDetail;

  @override
  Widget build(BuildContext context) {
    final bool hasImage = character.images.isNotEmpty;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 190,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Fond : image du personnage si dispo, sinon dégradé de repli.
            if (hasImage)
              Image.network(character.images.first, fit: BoxFit.cover)
            else
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2A2A3A), AppColors.dark],
                  ),
                ),
              ),
            // Voile sombre pour garder le texte lisible par-dessus l'image.
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black87, Colors.black38, Colors.black12],
                  stops: [0, 0.6, 1],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Personnage à la une',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        character.name,
                        style: AppTextStyles.h2.copyWith(color: Colors.white),
                      ),
                      if (tagline != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          tagline!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.85),
                          ),
                        ),
                      ],
                      const SizedBox(height: 14),
                      _SeeDetailButton(
                        onTap:
                            onSeeDetail ??
                            () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CharacterDetailScreen(
                                    character: character,
                                  ),
                                ),
                              );
                            },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SeeDetailButton extends StatelessWidget {
  const _SeeDetailButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Voir le détail',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 6),
              Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
