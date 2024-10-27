class TableModel {
  final String? id;
  final String number;
  final String capacity;

  TableModel({this.id, required this.number, required this.capacity});

  // Convert from Map to TableModel
  factory TableModel.fromMap(Map<String, dynamic> data, String id) {
    return TableModel(
      id: id,
      number: data['number'] ?? '',
      capacity: data['capacity'] ?? '',
    );
  }

  // Convert TableModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'capacity': capacity,
    };
  }
}
