import 'package:flutter/material.dart';
import 'package:shinobi_desk/core/theme/app_colors.dart';

class VillageData {
  const VillageData({
    required this.label,
    required this.color,
    required this.icon,
  });

  final String label;
  final Color color;
  final IconData icon;

  static const List<VillageData> all = [
    VillageData(
      label: 'Konoha',
      color: AppColors.konoha,
      icon: Icons.eco_rounded,
    ),
    VillageData(
      label: 'Suna',
      color: AppColors.suna,
      icon: Icons.wb_sunny_rounded,
    ),
    VillageData(
      label: 'Kiri',
      color: AppColors.kiri,
      icon: Icons.water_drop_rounded,
    ),
    VillageData(label: 'Kumo', color: AppColors.kumo, icon: Icons.bolt_rounded),
    VillageData(
      label: 'Iwa',
      color: AppColors.iwa,
      icon: Icons.terrain_rounded,
    ),
    VillageData(
      label: 'Akatsuki',
      color: AppColors.akatsuki,
      icon: Icons.cloud_rounded,
    ),
  ];
}
