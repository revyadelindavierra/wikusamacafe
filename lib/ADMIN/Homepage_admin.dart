import 'package:flutter/material.dart';
import 'package:wikusamacafe/ADMIN/EDIT_MENU/menu_header_Admin.dart';
import 'package:wikusamacafe/ADMIN/PERMEJAAN/MejaHeader.dart';
import 'package:wikusamacafe/ADMIN/Widget/StackAd.dart';
import 'package:wikusamacafe/ADMIN/Widget/menuaja.dart';
import 'package:wikusamacafe/ADMIN/Widget/tableaja.dart';

class HomeAadmin extends StatelessWidget {
  const HomeAadmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StackAdmin(),
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
            MenuHeaderAdmin(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: MenuAja(),
            ),
            const SizedBox(height: 22),
            MejaHeaderAdmin(),

            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 25), // Added horizontal padding for the table
              child: TableList(),
            ),
            const SizedBox(height: 20), // Adjusted spacing for clarity
          ],
        ),
      ),
    );
  }
}
