import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddNewMenuPage extends StatefulWidget {
  @override
  _AddNewMenuPageState createState() => _AddNewMenuPageState();
}

class _AddNewMenuPageState extends State<AddNewMenuPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _selectedCategory;
  String? _cloudImageUrl;
  double? _price;
  File? _imageFile;

  final List<String> categories = ['Packet', 'Snack', 'Drink'];

  // Pilih gambar dari perangkat
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

  // Upload gambar ke Firebase Storage
  Future<String?> _uploadImage() async {
    if (_imageFile == null) return null;

    String fileName =
        'menu_images/${DateTime.now().millisecondsSinceEpoch}_${_imageFile!.path.split('/').last}';
    try {
      final ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putFile(_imageFile!);
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl; // Kembalikan URL gambar yang diupload
    } catch (e) {
      print('Error uploading image: $e');
      return null; // Kembalikan null jika terjadi kesalahan
    }
  }

  // Simpan menu ke Firestore
  Future<void> _saveMenu() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Simpan data form

      String? imageUrl = await _uploadImage(); // Upload gambar dan dapatkan URL

      if (imageUrl != null) {
        try {
          // Simpan URL gambar ke Firestore dengan field cloudImageUrl
          await FirebaseFirestore.instance.collection('Menu').add({
            'name': _name,
            'price': _price,
            'cloudImageUrl': imageUrl, // Menggunakan cloudImageUrl
            'category': _selectedCategory // Menyimpan kategori jika diperlukan
          });

          // Reset form setelah berhasil menyimpan
          _formKey.currentState!.reset();
          setState(() {
            _imageFile = null; // Reset image file
            _cloudImageUrl = null; // Reset image URL
          });

          print('Menu saved successfully!');
        } catch (e) {
          print('Error saving menu to Firestore: $e');
        }
      } else {
        print('Image upload failed, cannot save menu.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Menu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Menu Name'),
                onSaved: (value) {
                  _name = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter menu name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _price = double.tryParse(value!);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Category'),
                value: _selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                validator: (value) =>
                    value == null ? 'Please select a category' : null,
              ),
              SizedBox(height: 16),
              _imageFile == null
                  ? Text('No image selected.')
                  : Image.file(_imageFile!, height: 100),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image from Gallery'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveMenu,
                child: Text('Save Menu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
