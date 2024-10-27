import 'package:flutter/material.dart';
import 'package:wikusamacafe/ADMIN/EDIT_MENU/Tambahan/BG_Atas.dart';
import 'package:wikusamacafe/ADMIN/EDIT_MENU/Tambahan/Pilihannya.dart';
import 'package:wikusamacafe/ADMIN/EDIT_MENU/Tambahan/Tombolnya.dart';

class Menu_awal extends StatelessWidget {
  const Menu_awal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BG_Atas(),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 18.5,
            decoration: const BoxDecoration(
              color: Color(0xff016042),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 19, left: 35, right: 35),
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    blurRadius: 19,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search Here',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 98, left: 45),
            child: Pilihannnyaaa(onMenuSelected: (String value) {  },),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 605,
            ),
            child: Center(child: Tomboll()),
          ),
        ],
      ),
    );
  }
}
