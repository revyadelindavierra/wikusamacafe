import 'package:flutter/material.dart';
import 'package:wikusamacafe/MANAGER/Widget/LihatEmploy.dart';
import 'package:wikusamacafe/MANAGER/Widget/menu_header.dart';
import 'package:wikusamacafe/MANAGER/Widget/pilihanmenu.dart';
import 'package:wikusamacafe/MANAGER/Widget/stack_ma.dart';

class HomeManager extends StatelessWidget {
  const HomeManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StackManager(),
            const SizedBox(height: 35),
            Center(
              child: SizedBox(
                height: 150,
                width: 355,
                child: Image.asset(
                  'lib/assets/Group.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 22),
            const MenuHeader(),
            const MenuManager(),
            const SizedBox(height: 22),
            const LihatEmploy(),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }
}
