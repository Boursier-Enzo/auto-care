import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/vehicle.dart';

class StorageService {
  static const String _key = 'vehicles';

  static Future<void> saveVehicles(List<Vehicle> vehicles) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(vehicles.map((v) => v.toJson()).toList());
    await prefs.setString(_key, data);
  }

  static Future<List<Vehicle>> loadVehicles() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];
    final List decoded = jsonDecode(data);
    return decoded.map((v) => Vehicle.fromJson(v)).toList();
  }
}
