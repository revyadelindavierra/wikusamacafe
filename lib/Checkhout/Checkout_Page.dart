import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wikusamacafe/Checkhout/Payment.dart';
import 'package:wikusamacafe/Checkhout/Total.dart';

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> selectedItems;
  final List<int> usedTableNumbers; // List of used table numbers

  const CheckoutPage({
    super.key,
    required this.selectedItems,
    required this.usedTableNumbers,
  });

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late List<int> itemCounts;
  String? _selectedTable; // Selected table number

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

    // List of table numbers 1-8
    List<String> tableNumbers =
        List.generate(8, (index) => (index + 1).toString());

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

          // Dropdown to select table number
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF016042)),
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              value: _selectedTable,
              onChanged: (newValue) {
                setState(() {
                  _selectedTable = newValue; // Save the selected value
                });
              },
              items: tableNumbers
                  .where((number) => !widget.usedTableNumbers
                      .contains(int.parse(number))) // Filter table numbers
                  .map((number) {
                return DropdownMenuItem(
                  value: number,
                  child: Text(number),
                );
              }).toList(),
              validator: (value) =>
                  value == null ? 'Please select a table number' : null,
            ),
          ),

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

          // List of order items
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
                          child: Image.network(
                            item['image_url'], // Use 'image_url' for the image
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 100,
                                height: 100,
                                color: Colors.grey[200],
                                child: const Center(
                                  child: Text('Image not available',
                                      style: TextStyle(color: Colors.red)),
                                ),
                              );
                            },
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
                      // Adjusted quantity buttons
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              setState(() {
                                if (itemCounts[index] > 1) {
                                  itemCounts[index]--;
                                } else {
                                  // Remove item if the count is 1
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
