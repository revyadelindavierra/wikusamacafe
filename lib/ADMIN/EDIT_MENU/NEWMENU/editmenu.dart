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
        'name': _name ?? _cloudImageUrl,
        'price': _price ?? _price,
        'cloudImageUrl': imageUrl ?? _cloudImageUrl,
      };
      await FirebaseFirestore.instance
          .collection('Menu')
          .doc(widget.menuId)
          .update(updatedData);

      print('Menu updated successfully!');
      Navigator.pop(context);
    }
  }

  Future<void> _deleteMenu() async {
    await FirebaseFirestore.instance
        .collection('Menu')
        .doc(widget.menuId)
        .delete();
    print('Menu deleted successfully!');
    Navigator.pop(context);
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
      appBar: AppBar(
        backgroundColor: const Color(0xFF016042),
        title: const Text(
          'Update Menu',
          style: TextStyle(color: Colors.white),
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
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      border: Border.all(color: const Color(0xFF016042)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: _imageFile == null && _cloudImageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              _cloudImageUrl!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : _imageFile == null
                            ? const Center(
                                child: Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Color(0xFF016042),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.file(
                                  _imageFile!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Menu Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                _buildTextField(
                  initialValue: _name,
                  hintText: 'Enter Menu Name',
                  onSave: (value) {
                    _name = value!.isEmpty ? _name : value;
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter menu name' : null,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Price',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                _buildTextField(
                  initialValue: _price?.toString(),
                  hintText: 'Enter Price',
                  keyboardType: TextInputType.number,
                  onSave: (value) {
                    _price = value!.isEmpty ? _price : double.tryParse(value);
                  },
                  validator: (value) =>
                      value!.isNotEmpty && double.tryParse(value) == null
                          ? 'Please enter a valid price'
                          : null,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _updateMenu,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF016042),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Update Menu',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _deleteMenu,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.withOpacity(0.5), // Softer red
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Delete Menu',
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

  Widget _buildTextField({
    required String? initialValue,
    required String hintText,
    required FormFieldSetter<String> onSave,
    required FormFieldValidator<String> validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      initialValue: initialValue,
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
}
