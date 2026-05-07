// lib/features/library/presentation/widgets/media_card.dart
import 'package:flutter/material.dart';

import '../../data/models/media_entry_model.dart';

class MediaCard extends StatelessWidget {
  const MediaCard({super.key, required this.entry});
  final MediaEntryModel entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: entry.coverUrl != null
            ? Image.network(
                entry.coverUrl!,
                width: 40,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const _CoverFallback(),
              )
            : const _CoverFallback(),
      ),
      title:    Text(entry.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text('${entry.type.label} · ${entry.status.label}',
          style: theme.textTheme.bodySmall),
      trailing: entry.rating != null
          ? Text('${entry.rating}/10',
              style: theme.textTheme.labelMedium)
          : null,
    );
  }
}

class _CoverFallback extends StatelessWidget {
  const _CoverFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 56,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: const Icon(Icons.image_not_supported_outlined, size: 20),
    );
  }
}