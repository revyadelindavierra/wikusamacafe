import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SuccessTransactions extends StatelessWidget {
  final String dateFilter; // Parameter baru untuk filter tanggal

  const SuccessTransactions({super.key, required this.dateFilter});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final orders = snapshot.data!.docs.where((order) {
          final timestamp = order['timestamp'] as Timestamp;
          final orderDate = DateFormat('dd-MM-yyyy').format(timestamp.toDate());
          return dateFilter.isEmpty || orderDate == dateFilter;
        }).toList();

        if (orders.isEmpty) {
          return const Center(child: Text('No transactions found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            final items = order['items'] as List<dynamic>;
            final timestamp = order['timestamp'] as Timestamp;
            final date = DateFormat('dd-MM-yyyy').format(timestamp.toDate());

            return Column(
              children: items.map((item) {
                final productName = item['name'];
                final quantity = item['count'];
                final price = item['price'];
                return TransactionTile(
                  quantity: quantity,
                  productName: productName,
                  date: date,
                  price: 'Rp ${price.toString()}',
                );
              }).toList(),
            );
          },
        );
      },
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
          Icons.check_circle,
          color: Color(0xFF016042),
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
            color: Color(0xFF016042),
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
