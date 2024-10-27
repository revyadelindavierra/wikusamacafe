// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:wikusamacafe/Checkhout/Checkout_Page.dart'; // Import CheckoutPage

// class Indoor extends StatefulWidget {
//   const Indoor({super.key});

//   @override
//   _IndoorState createState() => _IndoorState();
// }

// class _IndoorState extends State<Indoor> {
//   Set<String> selectedTables = {}; // Use String to match Firestore Document ID
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> fetchTableData() async {
//     QuerySnapshot snapshot = await _firestore
//         .collection('tables')
//         .get(); // Fetch all tables

//     setState(() {
//       // Update selectedTables based on documents
//       selectedTables = snapshot.docs
//           .map((doc) =>
//               doc.id) // Use Document ID (like 'table1', 'table2', etc.)
//           .toSet();
//     });
//   }

//   Future<void> updateTableStatus(String tableNumber, bool isSelected) async {
//     await _firestore.collection('tables').doc(tableNumber).set({
//       'isSelected': isSelected,
//     }, SetOptions(merge: true)); // Use merge to avoid overwriting other fields
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchTableData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 64,
//         backgroundColor: const Color(0xFF016042),
//         title: const Text(
//           "Choose Table",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(height: 16),
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 1,
//               ),
//               itemCount: 4, // Assuming there are 4 tables in the database
//               itemBuilder: (context, index) {
//                 String tableNumber = '${index + 1}'; // Generate Document ID
//                 bool isSelected =
//                     selectedTables.contains(tableNumber); // Check if selected

//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       // Update the selection status
//                       if (isSelected) {
//                         selectedTables.remove(tableNumber);
//                         updateTableStatus(tableNumber, false);
//                       } else {
//                         selectedTables.add(tableNumber);
//                         updateTableStatus(tableNumber, true);
//                       }
//                     });
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: isSelected ? Colors.transparent : Colors.grey[300],
//                       shape: isSelected ? BoxShape.circle : BoxShape.rectangle,
//                       border: isSelected
//                           ? Border.all(color: const Color(0xFF016042), width: 2)
//                           : null,
//                       borderRadius:
//                           isSelected ? null : BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       tableNumber.toUpperCase(), // Display the table number
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: isSelected
//                             ? const Color(0xFF016042)
//                             : Colors.grey[600],
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF016042),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 minimumSize: const Size(double.infinity, 56),
//               ),
//               onPressed: () {
//                 if (selectedTables.isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Please select at least one table.'),
//                       duration: Duration(seconds: 2),
//                     ),
//                   );
//                 } else {
//                   String selectedTableNumber =
//                       selectedTables.first; // Get the first selected table

//                   // Navigate to CheckoutPage and pass the selected table number
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => CheckoutPage(
//                         selectedItems: [], // Pass an empty list or actual selected items
//                         tableNumber: selectedTableNumber,
//                       ),
//                     ),
//                   );
//                 }
//               },
//               child: const Text(
//                 "Next",
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
