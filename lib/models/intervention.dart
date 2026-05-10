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

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'date': date.toIso8601String(),
    'note': note,
    'mileage': mileage,
  };

  factory Intervention.fromJson(Map<String, dynamic> json) => Intervention(
    id: json['id'],
    type: json['type'],
    date: DateTime.parse(json['date']),
    note: json['note'],
    mileage: json['mileage'],
  );
}
