import 'package:flutter/material.dart';
import '../models/intervention.dart';
import '../theme/app_theme.dart';

class InterventionTile extends StatelessWidget {
  final Intervention intervention;

  const InterventionTile({super.key, required this.intervention});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Type + date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(intervention.type, style: AppTheme.label),
              Text(
                '${intervention.date.day}/${intervention.date.month}/${intervention.date.year}',
                style: AppTheme.subtitle,
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Kilométrage
          Text('${intervention.mileage} km', style: AppTheme.subtitle),
          // Note si elle existe
          if (intervention.note != null) ...[
            const SizedBox(height: 6),
            Text(
              intervention.note!,
              style: AppTheme.subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis, // ← ajoute "..." si trop long
            ),
          ],
        ],
      ),
    );
  }
}
