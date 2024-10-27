import 'package:flutter/material.dart';
import 'package:wikusamacafe/Dashboard/widget/atas.dart';

class Stackkkk extends StatelessWidget {
  const Stackkkk({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Atasss(),
        Padding(
          padding: const EdgeInsets.only(top: 159, left: 35, right: 35),
          child: Container(
            height: 50,
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
