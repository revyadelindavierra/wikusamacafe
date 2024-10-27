import 'package:flutter/material.dart';

class lingkaran_element extends StatelessWidget {
  const lingkaran_element({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Lingkaran di pojok kanan atas
        Positioned(
          top: -50, 
          right: -50,
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Lingkaran di pojok kiri bawah
        Positioned(
          bottom: -50, 
          left: -50,
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
