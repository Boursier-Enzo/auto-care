import 'intervention.dart';

class Vehicle {
  final String id;
  String brand;
  String name;
  int year;
  int mileage;
  List<Intervention> interventions;

  Vehicle({
    required this.id,
    required this.brand,
    required this.name,
    required this.year,
    required this.mileage,
    this.interventions = const [],
  });
}
