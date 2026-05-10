import 'package:flutter/material.dart';
import '../models/vehicle.dart';
import '../models/intervention.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';
import '../widgets/intervention_tile.dart';

class VehicleDetailScreen extends StatefulWidget {
  final Vehicle vehicle;
  final List<Vehicle> allVehicles;

  const VehicleDetailScreen({
    super.key,
    required this.vehicle,
    required this.allVehicles,
  });

  @override
  State<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen> {
  late Vehicle vehicle;

  @override
  void initState() {
    super.initState();
    vehicle = widget.vehicle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: Text(vehicle.name)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${vehicle.brand} ${vehicle.name}', style: AppTheme.heading),
              const SizedBox(height: 8),
              Text(
                '${vehicle.year} · ${vehicle.mileage} km',
                style: AppTheme.subtitle,
              ),
              const SizedBox(height: 32),
              Text('Interventions', style: AppTheme.label),
              const SizedBox(height: 16),
              Expanded(
                child: vehicle.interventions.isEmpty
                    ? const Center(child: Text('Aucune intervention'))
                    : ListView.builder(
                        itemCount: vehicle.interventions.length,
                        itemBuilder: (context, index) {
                          final i = vehicle.interventions[index];
                          return InterventionTile(intervention: i);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddInterventionSheet,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddInterventionSheet() async {
    final typeController = TextEditingController();
    final noteController = TextEditingController();
    final mileageController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    if (!mounted) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            24,
            24,
            MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nouvelle intervention', style: AppTheme.heading),
              const SizedBox(height: 24),
              TextField(
                controller: typeController,
                decoration: const InputDecoration(
                  labelText: 'Type (vidange, freins...)',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: mileageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Kilométrage'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(
                  labelText: 'Note (optionnel)',
                ),
              ),
              const SizedBox(height: 12),
              // Date picker
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setSheetState(() => selectedDate = picked);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.border),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        style: AppTheme.subtitle,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final nav = Navigator.of(context);
                    final intervention = Intervention(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      type: typeController.text,
                      date: selectedDate,
                      note: noteController.text.isEmpty
                          ? null
                          : noteController.text,
                      mileage: int.tryParse(mileageController.text) ?? 0,
                    );
                    setState(
                      () => vehicle.interventions.insert(0, intervention),
                    );
                    final index = widget.allVehicles.indexWhere(
                      (v) => v.id == vehicle.id,
                    );
                    widget.allVehicles[index] = vehicle;
                    await StorageService.saveVehicles(widget.allVehicles);
                    nav.pop();
                  },
                  child: const Text('Ajouter'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
