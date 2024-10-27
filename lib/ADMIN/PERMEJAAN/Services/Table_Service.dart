import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wikusamacafe/ADMIN/PERMEJAAN/models/table_models.dart';

class TableService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<TableModel> _tables = [];

  // Mendapatkan semua tabel dari Firestore
  Future<List<TableModel>> getTables() async {
    final querySnapshot = await _firestore.collection('tables').get();
    _tables.clear(); // Hapus data lama
    for (var doc in querySnapshot.docs) {
      _tables.add(TableModel.fromMap(doc.data(), doc.id));
    }
    return _tables;
  }

  // Menambahkan tabel baru ke Firestore
  Future<void> addTable(TableModel table) async {
    await _firestore.collection('tables').add(table.toMap());
  }

  // Menghapus tabel dari Firestore berdasarkan ID
  Future<void> deleteTable(String id) async {
    await _firestore.collection('tables').doc(id).delete();
  }

  // Mengupdate data tabel di Firestore berdasarkan ID
  Future<void> updateTable(String id, TableModel updatedTable) async {
    await _firestore.collection('tables').doc(id).update(updatedTable.toMap());
  }
}
