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

  void _toggleItemSelection(int index) {
    setState(() {
      Map<String, dynamic> selectedItem = {
        'id': menuItems[index]['id'],
        'name': menuItems[index]['name'],
        'image_path': menuItems[index]['image_path'],
        'price': menuItems[index]['price'],
        'quantity': 1,
      };
      _selectedItems.add(selectedItem);
      selectedCount++;
    });
  }

  void _fetchMenuItems() {
    FirebaseFirestore.instance.collection('Menu').get().then((querySnapshot) {
      setState(() {
        menuItems = querySnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'],
            'image_path': doc['image_path'],
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
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: 100,
                                child: Image.asset(
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
                              'Rp ${item['price']}',
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
            ),
          ),
        ],
      ),
    );
  }
}
