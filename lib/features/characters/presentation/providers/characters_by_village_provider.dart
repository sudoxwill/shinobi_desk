import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinobi_desk/features/characters/domain/entities/character.dart';
import 'package:shinobi_desk/features/characters/presentation/providers/characters_provider.dart';

final charactersByVillageProvider =
    FutureProvider.family<List<Character>, String>((ref, village) async {
      final characters = await ref.read(charactersProvider.future);

      return Future.value(
        characters
            .where(
              (e) => e.affiliation.any(
                (aff) => aff.toLowerCase().contains(village.toLowerCase()),
              ),
            )
            .toList(),
      );
    });
