import 'package:flutter/material.dart';

class PilihanMenu extends StatefulWidget {
  final ValueChanged<String> onMenuSelected;

  PilihanMenu({required this.onMenuSelected});

  @override
  _PilihanMenuState createState() => _PilihanMenuState();
}

class _PilihanMenuState extends State<PilihanMenu> {
  String selectedButton = 'packet';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton('packet'),
          buildButton('Snacks/Food'),
          buildButton('Drink'),
        ],
      ),
    );
  }

  Widget buildButton(String text) {
    bool isSelected = selectedButton == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedButton = text;
        });
        widget.onMenuSelected(text);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF016042) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}