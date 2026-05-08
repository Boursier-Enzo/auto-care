class Intervention {
  final String id;
  String type;
  DateTime date;
  String? note;
  int mileage;

  Intervention({
    required this.id,
    required this.type,
    required this.date,
    this.note,
    required this.mileage,
  });
}
