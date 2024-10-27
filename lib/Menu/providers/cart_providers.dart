// class CartProvider with ChangeNotifier {
//   DBHelper db = DBHelper();
//   int _counter = 0;
//   int get counter => _counter;

//   double _totalPrice = 0.0; // Pastikan ini dideklarasikan dengan benar
//   double get totalPrice => _totalPrice;

//   late Future<List<Cart>> _cart;
//   Future<List<Cart>> get cart => _cart;

//   // Instance of Firestore
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<List<Cart>> getData() async {
//     _cart = db.getCartList();
//     return _cart;
//   }

//   void _setPrefItems() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setInt('cart_item', _counter);
//     prefs.setDouble('total_price', _totalPrice); // Pastikan _totalPrice digunakan dengan benar
//     notifyListeners();
//   }

//   void _getPrefItems() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _counter = prefs.getInt('cart_item') ?? 0;
//     _totalPrice = prefs.getDouble('total_price') ?? 0.0;
//     notifyListeners();
//   }

//   void addTotalPrice(double productPrice) {
//     _totalPrice += productPrice; // Menggunakan += untuk menambah harga
//     _setPrefItems();
//     notifyListeners();
//   }

//   void removeTotalPrice(double productPrice) {
//     _totalPrice -= productPrice; // Mengurangi harga
//     _setPrefItems();
//     notifyListeners();
//   }

//   // Method to save order to Firestore
//   Future<void> saveOrderToFirestore() async {
//     try {
//       Map<String, dynamic> orderData = {
//         'itemCount': _counter,
//         'totalPrice': _totalPrice,
//         // Tambahkan field lain jika perlu
//       };

//       await _firestore.collection('orders').add(orderData);
      
//       // Mengosongkan keranjang setelah menyimpan
//       _counter = 0;
//       _totalPrice = 0.0;
//       _setPrefItems();

//       notifyListeners(); 
//     } catch (error) {
//       print('Error saving order to Firestore: $error');
//     }
//   }
// }
