import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import untuk NumberFormat
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:wikusamacafe/Navbar/Navbar.dart';

class TotalAndButton extends StatelessWidget {
  final double total;
  final List<Map<String, dynamic>>
      selectedItems; // Menambahkan parameter selectedItems
  final List<int> itemCounts; // Menambahkan parameter itemCounts

  const TotalAndButton({
    super.key,
    required this.total,
    required this.selectedItems, // Mengharuskan passing selectedItems
    required this.itemCounts, // Mengharuskan passing itemCounts
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[800]),
              ),
              Text(
                currencyFormat.format(total), // Menggunakan format mata uang
                style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF016042),
              ),
              onPressed: () async {
                // Menyimpan data pesanan ke Firestore
                await FirebaseFirestore.instance.collection('orders').add({
                  'total': total,
                  'timestamp': FieldValue
                      .serverTimestamp(), // Untuk menyimpan waktu saat order
                  'items': selectedItems.map((item) {
                    int index = selectedItems.indexOf(item);
                    return {
                      'name': item['name'],
                      'price': item['price'],
                      'count': itemCounts[index], // Menyimpan jumlah item
                    };
                  }).toList(),
                });

                // Menampilkan dialog konfirmasi
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('LUNAS'),
                      content: const Text('Pesanan telah dibayar.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CurveNavigationWidget(),
                              ),
                            );
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text(
                "Make an Order",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
