import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wikusamacafe/ADMIN/EDIT_MENU/pilihanmenu_Admin.dart';

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

  Future<String?> _uploadImage() async {
    if (_imageFile == null) return null;

    String fileName =
        'menu_images/${DateTime.now().millisecondsSinceEpoch}_${_imageFile!.path.split('/').last}';
    try {
      final ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putFile(_imageFile!);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _saveMenu() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String? imageUrl = await _uploadImage();

      if (imageUrl != null) {
        try {
          String collection;
          if (_selectedCategory == 'Packet') {
            collection = 'Menu';
          } else if (_selectedCategory == 'Snack') {
            collection = 'Snack';
          } else if (_selectedCategory == 'Drink') {
            collection = 'Drink';
          } else {
            throw Exception('Kategori tidak valid');
          }

          await FirebaseFirestore.instance.collection(collection).add({
            'name': _name,
            'price': _price,
            'cloudImageUrl': imageUrl,
            'category': _selectedCategory,
          });

          _formKey.currentState!.reset();
          setState(() {
            _imageFile = null;
            _cloudImageUrl = null;
          });

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MenuAdmin()),
          );
        } catch (e) {
          print('Error saat menyimpan menu: $e');
        }
      } else {
        print('Gagal mengunggah gambar, tidak dapat menyimpan menu.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF016042),
        title: const Text(
          'New Menu',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Image',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF016042).withOpacity(0.1),
                      border: Border.all(color: const Color(0xFF016042)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: _imageFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(
                              _imageFile!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Center(
                            child: Icon(
                              Icons.image,
                              size: 50,
                              color: Color(0xFF016042),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildLabel('Name'),
                _buildTextField(
                  hintText: 'Enter Your New Menu Name',
                  onSave: (value) => _name = value,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter menu name' : null,
                ),
                const SizedBox(height: 24),
                _buildLabel('Description'),
                _buildTextField(
                  hintText: 'Enter Description Menu',
                  onSave: (value) => {}, // Handle if necessary
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a description' : null,
                ),
                const SizedBox(height: 24),
                _buildLabel('Category'),
                _buildDropdownField(),
                const SizedBox(height: 24),
                _buildLabel('Price'),
                _buildTextField(
                  hintText: 'Enter the Price',
                  keyboardType: TextInputType.number,
                  onSave: (value) => _price = double.tryParse(value!),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter price' : null,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _saveMenu,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF016042),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Create Menu',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required FormFieldSetter<String> onSave,
    required FormFieldValidator<String> validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF016042)),
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onSaved: onSave,
      validator: validator,
      keyboardType: keyboardType,
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF016042)),
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
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
      validator: (value) => value == null ? 'Please select a category' : null,
    );
  }
}
