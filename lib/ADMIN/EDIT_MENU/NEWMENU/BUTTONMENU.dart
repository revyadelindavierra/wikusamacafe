import 'package:flutter/material.dart';
import 'package:wikusamacafe/ADMIN/EDIT_MENU/Menu_Awal.dart';

class ButtonmenuAdmin extends StatelessWidget {
  const ButtonmenuAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Menu_awal()));
      },
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: ShapeDecoration(
          color: const Color(0xFF016042),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Center(
          child: Text(
            'Create Menu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
