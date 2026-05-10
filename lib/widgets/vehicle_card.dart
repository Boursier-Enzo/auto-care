import 'package:flutter/material.dart';
import '../models/vehicle.dart';
import '../theme/app_theme.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final VoidCallback onTap;

  const VehicleCard({super.key, required this.vehicle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            // Brand + name
            Text('${vehicle.brand} ${vehicle.name}', style: AppTheme.label),
            const SizedBox(height: 6),
            // Year + mileage
            Text(
              '${vehicle.year} · ${vehicle.mileage} km',
              style: AppTheme.subtitle,
            ),
            const SizedBox(height: 6),
            // Nb interventions
            Text(
              '${vehicle.interventions.length} intervention(s)',
              style: AppTheme.subtitle,
            ),
          ],
        ),
      ),
    );
  }
}
