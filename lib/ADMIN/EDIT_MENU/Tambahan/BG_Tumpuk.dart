import 'package:flutter/material.dart';
import 'package:wikusamacafe/ADMIN/EDIT_MENU/Tambahan/BG_Atas.dart';

class BG_Tumpuk extends StatelessWidget {
  const BG_Tumpuk({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BG_Atas(),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 4.5,
          decoration: const BoxDecoration(
            color: Color(0xff016042),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 159, left: 35, right: 35),
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}
