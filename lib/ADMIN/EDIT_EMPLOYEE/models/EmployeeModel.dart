enum UserRole { manager, admin, cashier }

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String password; // Tambahkan password di model

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.password, // Password wajib diisi
  });

  // Serialisasi untuk Firebase (dengan password)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.toString().split('.').last,
      'password': password, // Simpan password ke Firestore
    };
  }

  // Deserialisasi dari Firebase
  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: UserRole.values.firstWhere((e) => e.toString() == 'UserRole.${map['role']}'),
      password: map['password'] ?? '', // Ambil password dari Firestore
    );
  }
}
