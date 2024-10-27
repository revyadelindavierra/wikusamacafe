import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:wikusamacafe/Dashboard/homepage.dart';
import 'package:wikusamacafe/History/History_Page.dart';
import 'package:wikusamacafe/PROFILE/Profile.dart';

class CurveNavigationWidget extends StatefulWidget {
  const CurveNavigationWidget({super.key});

  @override
  State<CurveNavigationWidget> createState() => _CurveNavigationWidgetState();
}

class _CurveNavigationWidgetState extends State<CurveNavigationWidget> {
  int index = 0;

  final List<Widget> pages = [
     const HomepageK(),
    const TransactionHistoryPage(),
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
