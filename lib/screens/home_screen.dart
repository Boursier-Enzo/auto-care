import 'package:flutter/material.dart';
import '../models/vehicle.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';
import 'vehicle_detail_screen.dart';
import '../widgets/vehicle_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Vehicle> vehicles = [];

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  Future<void> _loadVehicles() async {
    final data = await StorageService.loadVehicles();
    setState(() => vehicles = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('AutoCare', style: AppTheme.heading),
              const SizedBox(height: 4),
              Text('${vehicles.length} véhicule(s)', style: AppTheme.subtitle),
              const SizedBox(height: 32),
              Expanded(
                child: vehicles.isEmpty
                    ? const Center(child: Text('Aucun véhicule'))
                    : ListView.builder(
                        itemCount: vehicles.length,
                        itemBuilder: (context, index) {
                          return VehicleCard(
                            vehicle: vehicles[index],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VehicleDetailScreen(
                                    vehicle: vehicles[index],
                                    allVehicles: vehicles,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddVehicleSheet,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddVehicleSheet() async {
    final brandController = TextEditingController();
    final nameController = TextEditingController();
    final yearController = TextEditingController();
    final mileageController = TextEditingController();

    if (!mounted) return;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
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
            Text('Nouveau véhicule', style: AppTheme.heading),
            const SizedBox(height: 24),
            TextField(
              controller: brandController,
              decoration: const InputDecoration(labelText: 'Marque'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Modèle'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Année'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: mileageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Kilométrage'),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  final nav = Navigator.of(context);
                  final vehicle = Vehicle(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    brand: brandController.text,
                    name: nameController.text,
                    year: int.tryParse(yearController.text) ?? 0,
                    mileage: int.tryParse(mileageController.text) ?? 0,
                  );
                  setState(() => vehicles.add(vehicle));
                  await StorageService.saveVehicles(vehicles);
                  nav.pop();
                },
                child: const Text('Ajouter'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
