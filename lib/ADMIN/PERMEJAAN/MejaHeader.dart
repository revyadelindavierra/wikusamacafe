import 'package:flutter/material.dart';
import 'package:wikusamacafe/ADMIN/EDIT_MENU/Menu_Awal.dart';
import 'package:wikusamacafe/ADMIN/EDIT_MENU/pilihanmenu_Admin.dart';
import 'package:wikusamacafe/ADMIN/PERMEJAAN/TablePage.dart';

class MejaHeaderAdmin extends StatelessWidget {
  const MejaHeaderAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Table Number',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TablePage()));
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
