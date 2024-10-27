import 'package:flutter/material.dart';
import 'package:wikusamacafe/Dashboard/widget/ButtonNew.dart';
import 'package:wikusamacafe/Dashboard/widget/Rules.dart';
import 'package:wikusamacafe/Dashboard/widget/stack.dart';
import 'package:wikusamacafe/Menu/Menu_Kasir/Menu_Page.dart';

class HomepageK extends StatelessWidget {
  const HomepageK({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Stackkkk(),
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
            const RulesPage(),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: ButtonNew(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  Menuuu()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
