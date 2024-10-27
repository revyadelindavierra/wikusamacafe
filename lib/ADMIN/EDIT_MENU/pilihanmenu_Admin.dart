import 'package:flutter/material.dart';
import 'package:wikusamacafe/ADMIN/EDIT_MENU/Jajanan.dart';
import 'package:wikusamacafe/ADMIN/EDIT_MENU/Minuman.dart';
import 'package:wikusamacafe/ADMIN/EDIT_MENU/Paketan.dart';
import 'package:wikusamacafe/ADMIN/Widget/barratasADmin.dart';
import 'package:wikusamacafe/Menu/widget_menu/Bar_Atas.dart';
import 'package:wikusamacafe/Menu/widget_menu/Pilihan_menu.dart';

class MenuAdmin extends StatefulWidget {
  const MenuAdmin({super.key});

  @override
  _MenuAdminState createState() => _MenuAdminState();
}

class _MenuAdminState extends State<MenuAdmin> {
  String selectedMenu = 'packet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarrAtasAdmin(),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 18.5,
            decoration: const BoxDecoration(
              color: Color(0xff016042),
            ),
          ),
          // Search Box
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
          // Pilihan Menu
          Padding(
            padding: const EdgeInsets.only(top: 98),
            child: PilihanMenu(
              onMenuSelected: (menu) {
                setState(() {
                  selectedMenu = menu;
                });
              },
            ),
          ),
          // Content based on selected tab
          Padding(
            padding: const EdgeInsets.only(top: 160, left: 35, right: 25),
            child: getSelectedMenuContent(),
          ),
        ],
      ),
    );
  }

  Widget getSelectedMenuContent() {
    if (selectedMenu == 'packet') {
      return PacketMenuPageAdmin();
    } else if (selectedMenu == 'Snacks/Food') {
      return SnackMenuPageAdmin();
    } else if (selectedMenu == 'Drink') {
      return MinumanPageAdmin();
    } else {
      return Container();
    }
  }
}
