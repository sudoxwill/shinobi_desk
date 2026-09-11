import 'package:flutter/material.dart';
import 'package:shinobi_desk/core/theme/app_colors.dart';
import 'package:shinobi_desk/core/theme/app_text_styles.dart';
import 'package:shinobi_desk/core/widgets/character_avatar.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';

class CharacterListTile extends StatelessWidget {
  const CharacterListTile({
    super.key,
    required this.character,
    this.onTap,
    this.trailing,
  });

  final Character character;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final village = character.affiliation!.isNotEmpty
        ? character.affiliation!.first
        : '—';

    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: CharacterAvatar(
        name: character.name,
        imageUrl: character.images.isNotEmpty ? character.images.first : null,
      ),
      title: Text(
        character.name,
        style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(village, style: AppTextStyles.bodySecondary),
      trailing:
          trailing ??
          const Icon(Icons.chevron_right, color: AppColors.textSecondary),
    );
  }
}
