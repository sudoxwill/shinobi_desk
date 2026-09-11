import 'package:flutter/material.dart';
import 'package:shinobi_desk/core/theme/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.onSeeAll});

  final String title;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.h3),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: Text('Voir tout', style: AppTextStyles.link),
          ),
      ],
    );
  }
}
