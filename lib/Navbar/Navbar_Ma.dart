import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:wikusamacafe/MANAGER/History_manager/History_Man.dart';
import 'package:wikusamacafe/MANAGER/HomePage_manager.dart';
import 'package:wikusamacafe/PROFILE/Profile.dart';

class NavbarMa extends StatefulWidget {
  const NavbarMa({super.key});

  @override
  State<NavbarMa> createState() => _NavbarMaState();
}

class _NavbarMaState extends State<NavbarMa> {
  int index = 0;

  final List<Widget> pages = [const HomeManager(), const TransactionMan(), const Profileee()];

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
          Icon(Icons.history, size: 30, color: Colors.white),
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
