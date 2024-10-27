import 'package:flutter/material.dart';
import 'package:wikusamacafe/ADMIN/EDIT_MENU/Menu_Awal.dart';
import 'package:wikusamacafe/ADMIN/EDIT_MENU/pilihanmenu_Admin.dart';

class MenuHeaderAdmin extends StatelessWidget {
  const MenuHeaderAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Menu',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MenuAdmin()));
            },
            child: const Text(
              'See All',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
