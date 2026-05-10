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

  Map<String, dynamic> toJson() => {
    'id': id,
    'brand': brand,
    'name': name,
    'year': year,
    'mileage': mileage,
    'interventions': interventions.map((i) => i.toJson()).toList(),
  };

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    id: json['id'],
    brand: json['brand'],
    name: json['name'],
    year: json['year'],
    mileage: json['mileage'],
    interventions: (json['interventions'] as List)
        .map((i) => Intervention.fromJson(i))
        .toList(),
  );
}
