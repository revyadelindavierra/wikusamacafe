import 'package:flutter/material.dart';
import 'package:wikusamacafe/Nota/Widget/Button.dart';
import 'package:wikusamacafe/Nota/Widget/Payment.dart';
import 'package:wikusamacafe/Nota/Widget/Subtotalnya.dart';
import 'package:wikusamacafe/Nota/Widget/Table_Atas.dart';

class Notaaa extends StatelessWidget {
  const Notaaa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: const Center(
          child: Text(
            'Receipt',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: const Color(0xFF016042),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TableAtas(tableNumbers: '21'),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date :',
                      style: TextStyle(fontSize: 17),
                    ),
                    Text('22 - 09 - 2024', style: TextStyle(fontSize: 17)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Cashier :', style: TextStyle(fontSize: 17)),
                    Text('Lana Impreion', style: TextStyle(fontSize: 17)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Payment :', style: TextStyle(fontSize: 17)),
                    Text('Cash', style: TextStyle(fontSize: 17)),
                  ],
                ),
                Divider(thickness: 1),
              ],
            ),
          ),
          const PaymentDetailsnya(),
          const Subtotalnyaaaaa(),
          const SizedBox(height: 205),
          FinishButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
