import 'package:flutter/material.dart';

class TableAtas extends StatelessWidget {
  final String tableNumbers;

  const TableAtas({super.key, required this.tableNumbers});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF9E0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const Icon(
            Icons.table_restaurant_sharp,
            size: 42,
            color: Color(0xFF016042),
          ),
          const SizedBox(width: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Table Number',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Text(
                tableNumbers,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
