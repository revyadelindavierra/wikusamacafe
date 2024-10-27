import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wikusamacafe/ADMIN/EDIT_MENU/NEWMENU/editmenu.dart';
import 'package:wikusamacafe/ADMIN/EDIT_MENU/Tambahan/Tombolnya.dart';

class SnackMenuPageAdmin extends StatefulWidget {
  @override
  _SnackMenuPageAdminState createState() => _SnackMenuPageAdminState();
}

class _SnackMenuPageAdminState extends State<SnackMenuPageAdmin> {
  List<Map<String, dynamic>> menuItems = [];
  List<Map<String, dynamic>> _selectedItems = [];
  int selectedCount = 0;

  void _toggleItemSelection(int index) {
    setState(() {
      Map<String, dynamic> selectedItem = {
        'id': menuItems[index]['id'],
        'name': menuItems[index]['name'],
        'price': menuItems[index]['price'],
        'image_url': menuItems[index]
            ['cloudImageUrl'], // Ganti dengan URL gambar
        'quantity': 1,
      };
      _selectedItems.add(selectedItem);
      selectedCount++;
    });
  }

  void _fetchMenuItems() {
    FirebaseFirestore.instance.collection('Snack').get().then((querySnapshot) {
      setState(() {
        menuItems = querySnapshot.docs.map((doc) {
          print(
              'Fetching menu item: ${doc['name']}, Image URL: ${doc['cloudImageUrl']}'); // Menggunakan cloudImageUrl

          return {
            'id': doc.id,
            'name': doc['name'],
            'cloudImageUrl': doc[
                'cloudImageUrl'], // Pastikan ini adalah nama field yang benar
            'price': doc['price'],
          };
        }).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: menuItems.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      final item = menuItems[index];
                      return Column(
                        children: [
                          ListTile(
                            leading: _buildImageOrPlaceholder(item[
                                'cloudImageUrl']), // Ganti dengan cloudImageUrl
                            title: Text(
                              item['name'],
                              style: TextStyle(fontSize: 18),
                            ),
                            subtitle: Text(
                              'Rp ${item['price']}',
                              style: TextStyle(fontSize: 15),
                            ),
                            onTap: () {
                              // Navigate to the Update Menu Item screen
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         UpdateMenuPage(menuItem: item),
                              //   ),
                              // );
                            },
                          ),
                          Divider(),
                        ],
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Tomboll(), // Assuming Tomboll is a custom widget for buttons
          ),
        ],
      ),
    );
  }

  Widget _buildImageOrPlaceholder(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      // Show the image if the URL is valid
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 100,
          height: 100, // Adjust height to match width
          child: Image.network(
            imageUrl, // Menggunakan URL gambar dari Firebase
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      // Show a placeholder if no image URL is provided
      return Container(
        width: 100,
        height: 100, // Maintain same size for consistency
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200], // Light grey background
        ),
        child: Center(
          child: Text(
            'Image not uploaded',
            style: TextStyle(
              color: Colors.red, // Red text for visibility
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
}
