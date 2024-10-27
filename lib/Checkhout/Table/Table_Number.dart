import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TableNumberWidget extends StatefulWidget {
  @override
  _TableNumberWidgetState createState() => _TableNumberWidgetState();
}

class _TableNumberWidgetState extends State<TableNumberWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _selectedTableNumber; // To store selected table number
  List<String> _tableNumbers = []; // List of table numbers
  Map<String, bool> _tableSelectionStatus =
      {}; // Map to store isSelected status

  @override
  void initState() {
    super.initState();
    _fetchTableNumbers(); // Fetch table numbers from Firestore
  }

  // Fetch table numbers from Firestore
  Future<void> _fetchTableNumbers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('tables').get();
      List<String> tableNumbers = [];
      Map<String, bool> tableStatus = {};

      for (var doc in snapshot.docs) {
        String tableNumber = doc.id; // Use document ID as table number
        bool isSelected = doc['isSelected'] ?? false; // Fetch selection status
        tableNumbers.add(tableNumber);
        tableStatus[tableNumber] = isSelected; // Store the selection status
      }

      setState(() {
        _tableNumbers = tableNumbers;
        _tableSelectionStatus = tableStatus;
      });
    } catch (e) {
      print('Error fetching table numbers: $e');
    }
  }

  // Update table selection in Firestore when a table is selected
  Future<void> _updateTableSelection(String tableNumber) async {
    await _firestore
        .collection('tables')
        .doc(tableNumber)
        .update({'isSelected': true});

    setState(() {
      _selectedTableNumber = tableNumber; // Update the selected table number
      _tableSelectionStatus[tableNumber] = true; // Mark it as selected
    });
  }

  // Show table selection dialog
  void _showTableSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Table'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _tableNumbers.map((tableNumber) {
                bool isDisabled = _tableSelectionStatus[tableNumber] ?? false;
                return ListTile(
                  title: Text(
                    tableNumber,
                    style: TextStyle(
                      color: isDisabled ? Colors.grey : Colors.black,
                      fontWeight:
                          isDisabled ? FontWeight.w300 : FontWeight.bold,
                    ),
                  ),
                  enabled: !isDisabled,
                  onTap: () {
                    if (!isDisabled) {
                      _updateTableSelection(
                          tableNumber); // Update selection in Firestore
                      Navigator.of(context).pop(); // Close the dialog
                    }
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showTableSelectionDialog(
          context), // Show table selection dialog when tapped
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Lebarkan kontainer
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Table Number',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8.0),
            // Display selected table number or default text
            Text(
              _selectedTableNumber != null
                  ? 'Selected Table: $_selectedTableNumber' // Display selected table number
                  : 'No table selected', // Default text
              style: TextStyle(
                fontSize: 18.0,
                color:
                    _selectedTableNumber == null ? Colors.grey : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
