import 'package:intl/intl.dart';

class Subtotal {
  final List<Map<String, dynamic>> selectedItems;

  Subtotal(this.selectedItems);

  double HitungTotal() {
    double subtotal = 0;
    for (var item in selectedItems) {
      subtotal += item['price'] * item['quantity'];
    }
    return subtotal;
  }

  double calculateTax() {
    return 5000; // Ubah ini sesuai logika pajak Anda
  }

  double calculateTotal() {
    double subtotal = HitungTotal();
    double tax = calculateTax();
    return subtotal + tax;
  }

  String formatCurrency(double amount) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return currencyFormat.format(amount);
  }
}
