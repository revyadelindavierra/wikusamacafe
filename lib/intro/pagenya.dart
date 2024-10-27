import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;

  const PageIndicator({required this.currentPage, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(3, (int index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: 10,
          width: (currentPage == index) ? 20 : 10,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: (currentPage == index) ? Colors.green : Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }
}