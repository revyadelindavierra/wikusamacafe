import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wikusamacafe/ADMIN/EDIT_EMPLOYEE/models/EmployeeModel.dart';

class UserService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // Mendapatkan Stream dari data pengguna
  Stream<List<User>> getUserStream() {
    return userCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return User.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Menambahkan pengguna baru ke Firestore
  Future<void> addUser(User user) {
    return userCollection.add(user.toMap());
  }

  // Menghapus pengguna berdasarkan ID
  Future<void> deleteUser(String userId) {
    return userCollection.doc(userId).delete();
  }

  // Memperbarui pengguna berdasarkan ID
  Future<void> updateUser(User user) {
    return userCollection.doc(user.id).update(user.toMap());
  }
}
