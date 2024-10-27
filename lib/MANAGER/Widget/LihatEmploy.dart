import 'package:flutter/material.dart';

class LihatEmploy extends StatelessWidget {
  const LihatEmploy({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> employees = [
      {'name': 'Lana Impreion', 'position': 'Admin'},
      {'name': 'John Doe', 'position': 'Cashier'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Employee',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            children: employees.map((employee) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        employee['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        employee['position']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
