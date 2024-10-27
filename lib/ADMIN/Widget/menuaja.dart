import 'package:flutter/material.dart';

class MenuAja extends StatelessWidget {
  MenuAja({Key? key}) : super(key: key);

  // Array lokal untuk menampilkan data menu
  final List<Map<String, dynamic>> menuItems = [
    {
      'name': 'Nasi Goreng',
      'description': 'Nasi goreng dengan telur dan ayam',
      'price': 20000,
    },
    {
      'name': 'Mie Ayam',
      'description': 'Mie ayam dengan tambahan bakso',
      'price': 18000,
    },
    {
      'name': 'Sate Ayam',
      'description': 'Sate ayam dengan saus kacang',
      'price': 25000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Prevent scrolling
      itemCount: menuItems.length,
      separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.grey), // Divider between items
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return ListTile(
          title: Text(item['name']),
          subtitle: Text(item['description']),
          trailing: Text('Rp${item['price']}', style: const TextStyle(fontWeight: FontWeight.bold)),
        );
      },
    );
  }
}
