import 'package:flutter/material.dart';

class FailedTransactions extends StatelessWidget {
  const FailedTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        TransactionTile(
          quantity: 1,
          productName: "Cappuccino",
          date: "20-09-2024",
          price: "Rp 50.000",
        ),
        TransactionTile(
          quantity: 3,
          productName: "Latte",
          date: "18-09-2024",
          price: "Rp 90.000",
        ),
        // Tambahkan lebih banyak transaksi gagal jika diperlukan
      ],
    );
  }
}

class TransactionTile extends StatelessWidget {
  final int quantity;
  final String productName;
  final String date;
  final String price;

  const TransactionTile({
    super.key,
    required this.quantity,
    required this.productName,
    required this.date,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const Icon(
          Icons.cancel,
          color: Colors.red,
        ),
        title: Text(
          '$quantity x $productName',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(date),
        trailing: Text(
          price,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
