import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:wikusamacafe/ADMIN/EDIT_EMPLOYEE/EmployeeScreen.dart';
import 'package:wikusamacafe/ADMIN/Homepage_admin.dart';
import 'package:wikusamacafe/PROFILE/Profile.dart';

class Navbaradmin extends StatefulWidget {
  const Navbaradmin({super.key});

  @override
  State<Navbaradmin> createState() => _NavbaradminState();
}

class _NavbaradminState extends State<Navbaradmin> {
  int index = 0;

  final List<Widget> pages = [
    const HomeAadmin(),
    HomeScreen(),
    const Profileee()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: CurvedNavigationBar(
        color: const Color(0xFF016042),
        backgroundColor: Colors.white,
        height: 70,
        index: index,
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.business_center, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: (newIndex) {
          setState(() {
            index = newIndex;
          });
        },
      ),
    );
  }
}
