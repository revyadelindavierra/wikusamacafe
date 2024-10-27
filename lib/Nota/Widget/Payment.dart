import 'package:flutter/material.dart';

class PaymentDetailsnya extends StatelessWidget {
  const PaymentDetailsnya({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 19),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('1x Esspresso', style: TextStyle(fontSize: 17)),
              Text('Rp 34.800', style: TextStyle(fontSize: 17)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('1x Esspresso', style: TextStyle(fontSize: 17)),
              Text('Rp 34.800', style: TextStyle(fontSize: 17)),
            ],
          ),
          Divider(thickness: 1),
        ],
      ),
    );
  }
}
