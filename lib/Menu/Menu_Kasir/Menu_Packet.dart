import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wikusamacafe/Menu/widget_menu/Button_bawah.dart';

class PacketMenuPage extends StatefulWidget {
  @override
  _PacketMenuPageState createState() => _PacketMenuPageState();
}

class _PacketMenuPageState extends State<PacketMenuPage> {
  List<Map<String, dynamic>> menuItems = [];
  List<Map<String, dynamic>> _selectedItems = [];
  int selectedCount = 0;

  // To store the used table numbers
  List<int> usedTableNumbers = [];

  void _toggleItemSelection(int index) {
    setState(() {
      Map<String, dynamic> selectedItem = {
        'id': menuItems[index]['id'],
        'name': menuItems[index]['name'],
        'price': menuItems[index]['price'],
        'image_url': menuItems[index]['cloudImageUrl'],
        'quantity': 1,
      };
      _selectedItems.add(selectedItem);
      selectedCount++;
    });
  }

  Future<void> _fetchMenuItems() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Menu').get();
      setState(() {
        menuItems = querySnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'] ?? 'Unknown',
            'cloudImageUrl':
                doc['cloudImageUrl'], // Ensure this field is correctly named
            'price': doc['price'] ?? 0,
          };
        }).toList();
      });
    } catch (error) {
      print('Error fetching menu items: $error');
    }
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
                            leading:
                                _buildImageOrPlaceholder(item['cloudImageUrl']),
                            title: Text(
                              item['name'] ?? 'Unknown',
                              style: TextStyle(fontSize: 18),
                            ),
                            subtitle: Text(
                              'Rp ${item['price']}', // Use the fetched price
                              style: TextStyle(fontSize: 15),
                            ),
                            onTap: () => _toggleItemSelection(index),
                          ),
                          Divider(),
                        ],
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ButtonnBawah(
              itemCount: selectedCount,
              selectedItems: _selectedItems,
              usedTableNumbers: usedTableNumbers,
            ),
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
            imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            },
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              // Display an empty box if there's an error
              return Container(
                width: 100,
                height: 100,
                color: Colors.grey[200], // Maintain the empty box
                child: Center(
                  child: Text(
                    'Image not available',
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
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
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
}
