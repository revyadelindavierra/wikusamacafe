import 'package:flutter/material.dart';
import 'package:wikusamacafe/Navbar/Navbar.dart';

class AppBarnya extends StatelessWidget implements PreferredSizeWidget {
  const AppBarnya({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 96,
      flexibleSpace: Container(
        decoration: const BoxDecoration(color: Color(0xFF016042)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 22, left: 25),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 32,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const CurveNavigationWidget()),
                  );
                },
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 176, top: 22),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // Gambar di sebelah kanan jika ada
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(96);
}
