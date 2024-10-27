import 'package:flutter/material.dart';
import 'package:wikusamacafe/Navbar/Navbar.dart';
import 'package:wikusamacafe/Navbar/Navbar_Ad.dart';
import 'package:wikusamacafe/Navbar/Navbar_Ma.dart';
import 'dropdown.dart';

class Roless extends StatefulWidget {
  const Roless({super.key});

  @override
  State<Roless> createState() => _RolessState();
}

class _RolessState extends State<Roless> {
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFF016042)),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 65, left: 28),
                  child: const Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "Welcome\nBack",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 43,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 45),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                padding: const EdgeInsets.only(left: 15),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20, top: 45),
                          child: Text(
                            'Roles',
                            style: TextStyle(
                              color: Color.fromARGB(255, 41, 30, 30),
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: RoleDropdown(
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedRole = newValue;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 190),
                        Padding(
                          padding: const EdgeInsets.only(left: 35, right: 35),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_selectedRole == 'admin') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  const Navbaradmin()),
                                );
                              } else if (_selectedRole == 'cashier') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                           const CurveNavigationWidget()),
                                );
                              } else if (_selectedRole == 'manager') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  const NavbarMa()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please select a role')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF016042),
                              fixedSize: const Size(300, 48),
                            ),
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
