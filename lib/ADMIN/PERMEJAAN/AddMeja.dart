import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNewTablePage extends StatefulWidget {
  @override
  _AddNewTablePageState createState() => _AddNewTablePageState();
}

class _AddNewTablePageState extends State<AddNewTablePage> {
  final TextEditingController _tableNumberController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addTable() async {
    final tableNumber = _tableNumberController.text;
    final capacity = _capacityController.text;

    if (tableNumber.isEmpty || capacity.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final existingTables = await _firestore
        .collection('tables')
        .where('number', isEqualTo: tableNumber)
        .get();

    if (existingTables.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Table number $tableNumber already exists')),
      );
      return;
    }

    await _firestore.collection('tables').add({
      'number': tableNumber,
      'capacity': capacity,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Table added successfully')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: Padding(
          padding: const EdgeInsets.only(top: 5, left: 55),
          child: Text(
            'Add New Table',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Color(0xFF016042),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Number of Tables',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF016042),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _tableNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter table number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Capacity',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF016042),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _capacityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter capacity',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: _addTable,
              child: Container(
                width: double.infinity,
                height: 49,
                decoration: BoxDecoration(
                  color: Color(0xFF016042),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    'Add New Table',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
