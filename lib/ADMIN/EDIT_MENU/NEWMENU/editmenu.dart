import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UpdateMenuPage extends StatefulWidget {
  final String menuId;

  UpdateMenuPage({required this.menuId});

  @override
  _UpdateMenuPageState createState() => _UpdateMenuPageState();
}

class _UpdateMenuPageState extends State<UpdateMenuPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  double? _price;
  String? _cloudImageUrl;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _fetchMenuItem();
  }

  Future<void> _fetchMenuItem() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Menu')
        .doc(widget.menuId)
        .get();
    setState(() {
      _name = doc['name'];
      _price = doc['price'];
      _cloudImageUrl = doc['cloudImageUrl'];
    });
  }

  Future<String?> _uploadImage() async {
    if (_imageFile == null) return null;

    String fileName =
        'menu_images/${DateTime.now().millisecondsSinceEpoch}_${_imageFile!.path.split('/').last}';
    try {
      final ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putFile(_imageFile!);
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _updateMenu() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String? imageUrl = await _uploadImage();
      Map<String, dynamic> updatedData = {
        'name': _name ?? _cloudImageUrl, // Gunakan nilai lama jika tidak diubah
        'price': _price ?? _price, // Gunakan nilai lama jika tidak diubah
        'cloudImageUrl': imageUrl ?? _cloudImageUrl,
      };

      await FirebaseFirestore.instance
          .collection('Menu')
          .doc(widget.menuId)
          .update(updatedData);

      _formKey.currentState!.reset();
      setState(() {
        _imageFile = null;
        _cloudImageUrl = null;
      });

      print('Menu updated successfully!');
      Navigator.pop(context);
    }
  }

  Future<void> _deleteMenu() async {
    // Delete the menu item from Firestore
    await FirebaseFirestore.instance
        .collection('Menu')
        .doc(widget.menuId)
        .delete();
    print('Menu deleted successfully!');
    Navigator.pop(context); // Go back after deletion
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Menu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Menu Name'),
                onSaved: (value) {
                  _name = value!.isEmpty
                      ? _name
                      : value; // Gunakan nilai lama jika dibiarkan kosong
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter menu name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _price?.toString(),
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _price = value!.isEmpty
                      ? _price
                      : double.tryParse(
                          value); // Gunakan nilai lama jika dibiarkan kosong
                },
                validator: (value) {
                  if (value!.isNotEmpty && double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              _imageFile == null && _cloudImageUrl != null
                  ? Image.network(_cloudImageUrl!, height: 100)
                  : _imageFile == null
                      ? Text('No image selected.')
                      : Image.file(_imageFile!, height: 100),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image from Gallery'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateMenu,
                child: Text('Update Menu'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _deleteMenu,
                child: Text('Delete Menu', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
