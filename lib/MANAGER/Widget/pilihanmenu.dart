import 'package:flutter/material.dart';

class MenuManager extends StatelessWidget {
  MenuManager({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> menuItems = [
    {'title': 'Burger', 'price': '\Rp5.990'},
    {'title': 'Pizza', 'price': '\Rp8.990'},
    {'title': 'Pasta', 'price': '\Rp7.490'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Column(
            children: menuItems.map((item) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF271F1F),
                        ),
                      ),
                      Text(
                        item['price'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6D6565),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
