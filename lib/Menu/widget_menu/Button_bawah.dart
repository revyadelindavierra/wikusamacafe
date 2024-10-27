import 'package:flutter/material.dart';
import 'package:wikusamacafe/Checkhout/Checkout_Page.dart';

class ButtonnBawah extends StatefulWidget {
  final int itemCount;
  final List<Map<String, dynamic>> selectedItems;
  final List<int> usedTableNumbers; // Added parameter for used table numbers

  const ButtonnBawah({
    super.key,
    required this.itemCount,
    required this.selectedItems,
    required this.usedTableNumbers, // Include the new parameter
  });

  @override
  _ButtonnBawahState createState() => _ButtonnBawahState();
}

class _ButtonnBawahState extends State<ButtonnBawah> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutPage(
                  selectedItems: widget.selectedItems,
                  usedTableNumbers:
                      widget.usedTableNumbers, // Pass the used table numbers
                ),
              ),
            );
          },
          child: SizedBox(
            width: 335,
            height: 49,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 330,
                    height: 50,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF016042),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  right: 20,
                  top: 8,
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 13,
                  child: Text(
                    '${widget.itemCount} Items', // Show the item count
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Positioned(
                  right: 62,
                  top: 13,
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
