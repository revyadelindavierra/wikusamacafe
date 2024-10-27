class MenuItem {
  final String category;
  final String cloudImageUrl;
  final String description;
  final String id;
  final String name;
  final double price; // Changed to double

  MenuItem({
    required this.category,
    required this.cloudImageUrl,
    required this.description,
    required this.id,
    required this.name,
    required this.price,
  });

  // Convert a MenuItem to a Map for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'cloudImageUrl': cloudImageUrl,
      'description': description,
      'id': id,
      'name': name,
      'price': price,
    };
  }

  // Convert a Map from Firestore to a MenuItem
  factory MenuItem.fromMap(String id, Map<String, dynamic> map) {
    return MenuItem(
      category: map['category'] ?? '',
      cloudImageUrl: map['cloudImageUrl'] ?? '',
      description: map['description'] ?? '',
      id: id,
      name: map['name'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(), // Ensure price is double
    );
  }
}
