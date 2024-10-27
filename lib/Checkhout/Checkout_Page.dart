import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wikusamacafe/Checkhout/Payment.dart';
import 'package:wikusamacafe/Checkhout/Total.dart'; // Ensure this is imported

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> selectedItems;

  const CheckoutPage({super.key, required this.selectedItems});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late List<int> itemCounts;

  @override
  void initState() {
    super.initState();
    itemCounts = List<int>.generate(widget.selectedItems.length, (index) => 1);
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = 0;
    for (int i = 0; i < widget.selectedItems.length; i++) {
      subtotal += widget.selectedItems[i]['price'] * itemCounts[i];
    }
    double tax = 5000;
    double total = subtotal + tax;

    final currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: const Color(0xFF016042),
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: Colors.grey[300], thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Order Details',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    // Action to add item
                  },
                  child: const Text('Add Item'),
                ),
              ],
            ),
          ),
          // Wrap the ListView.builder in Expanded to avoid infinite size error
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedItems.length,
              itemBuilder: (context, index) {
                final item = widget.selectedItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 4.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            item['image_path'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(currencyFormat.format(item['price']),
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              setState(() {
                                if (itemCounts[index] > 1) {
                                  itemCounts[index]--;
                                } else {
                                  // Hapus item jika jumlahnya 1
                                  widget.selectedItems.removeAt(index);
                                  itemCounts.removeAt(index);
                                }
                              });
                            },
                          ),
                          Text(itemCounts[index].toString(),
                              style: const TextStyle(fontSize: 16)),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                              setState(() {
                                itemCounts[index]++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(color: Colors.grey[300], thickness: 1),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal'),
                    Text(currencyFormat.format(subtotal)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tax'),
                    Text(currencyFormat.format(tax)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(currencyFormat.format(total),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey[300], thickness: 1),
          const PaymentMethod(),
          Divider(color: Colors.grey[300], thickness: 1),
          TotalAndButton(
            total: total,
            selectedItems: widget.selectedItems,
            itemCounts: itemCounts,
          ),
        ],
      ),
    );
  }
}
