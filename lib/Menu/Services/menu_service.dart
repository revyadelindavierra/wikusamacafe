import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wikusamacafe/Menu/Models/menu_model.dart';
import 'dart:io';

class MenuService {
  final String collectionName;
  final CollectionReference collection;

  MenuService(this.collectionName)
      : collection = FirebaseFirestore.instance.collection(collectionName);

  // Add a new menu item
  Future<void> addMenuItem(MenuItem item) async {
    await collection.doc(item.id).set(item.toMap());
  }

  // Upload image to Firebase Storage
  Future<String?> uploadImage(File imageFile) async {
    try {
      // Create a reference to Firebase Storage
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('menu_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Upload the image to Firebase Storage
      await storageRef.putFile(imageFile);

      // Get the download URL
      String downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl; // Kembalikan URL
    } catch (e) {
      print('Failed to upload image: $e');
      return null; // Kembalikan null jika gagal
    }
  }

  // Get all items in the collection
  Future<List<MenuItem>> getAllItems() async {
    final snapshot = await collection.get();
    return snapshot.docs.map((doc) => MenuItem.fromMap(doc.id, doc.data() as Map<String, dynamic>)).toList();
  }

  // Get a single item by ID
  Future<MenuItem?> getMenuItemById(String id) async {
    final docSnapshot = await collection.doc(id).get();
    if (docSnapshot.exists) {
      return MenuItem.fromMap(docSnapshot.id, docSnapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Update a menu item by ID
  Future<void> updateMenuItem(String id, MenuItem updatedItem) async {
    await collection.doc(id).update(updatedItem.toMap());
  }

  // Delete a menu item by ID
  Future<void> deleteMenuItem(String id) async {
    await collection.doc(id).delete();
  }
}
