import 'package:flutter/material.dart';
import 'package:wikusamacafe/ADMIN/EDIT_EMPLOYEE/New_employ.dart';
import 'package:wikusamacafe/ADMIN/EDIT_MENU/NEWMENU/New_Menu.dart';

class Tomboll extends StatelessWidget {
  const Tomboll({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddNewMenuPage()));
          },
          child: SizedBox(
            width: 335,
            height: 49,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 330,
                    height: 50,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF016042),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'New Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
