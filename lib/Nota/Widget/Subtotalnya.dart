import 'package:flutter/material.dart';

class Subtotalnyaaaaa extends StatelessWidget {
  const Subtotalnyaaaaa({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal', style: TextStyle(fontSize: 17)),
              Text('Rp 69.600', style: TextStyle(fontSize: 17)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tax', style: TextStyle(fontSize: 17)),
              Text('Rp 2.000', style: TextStyle(fontSize: 17)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF016042),
                    fontSize: 17),
              ),
              Text(
                'Rp 71.600',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF016042),
                    fontSize: 17),
              ),
            ],
          ),
          Divider(thickness: 1),
        ],
      ),
    );
  }
}
