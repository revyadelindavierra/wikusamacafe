import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wikusamacafe/Menu/widget_menu/Button_bawah.dart';

class SnackMenuPage extends StatefulWidget {
  @override
  _SnackMenuPageState createState() => _SnackMenuPageState();
}

class _SnackMenuPageState extends State<SnackMenuPage> {
  List<Map<String, dynamic>> menuItems = [];
  List<Map<String, dynamic>> _selectedItems = [];
  int selectedCount = 0;

  void _toggleItemSelection(int index) {
    setState(() {
      menuItems[index]['selected'] = !menuItems[index]['selected'];
      if (menuItems[index]['selected']) {
        _selectedItems.add(menuItems[index]);
        selectedCount++;
      } else {
        _selectedItems.remove(menuItems[index]);
        selectedCount--;
      }
    });
  }

  void _fetchMenuItems() {
    FirebaseFirestore.instance.collection('Snack').get().then((querySnapshot) {
      setState(() {
        menuItems = querySnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'],
            'image_path': doc['image_path'],
            'price': doc['price'],
            'selected': false,
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
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: SizedBox(
                            width: 120,
                            height: 120, // Adjusted height for better layout
                            child: item['image_path'] != null &&
                                    (item['image_path'].startsWith('http') ||
                                        item['image_path'].startsWith('https'))
                                ? Image.network(
                                    item['image_path'],
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    item['image_path'],
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        title: Text(
                          item['name'],
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          ' Rp ${item['price']}',
                          style: TextStyle(fontSize: 15),
                        ),
                        onTap: () => _toggleItemSelection(index),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ButtonnBawah(
              itemCount: selectedCount,
              selectedItems: _selectedItems,
            ),
          ),
        ],
      ),
    );
  }
}
