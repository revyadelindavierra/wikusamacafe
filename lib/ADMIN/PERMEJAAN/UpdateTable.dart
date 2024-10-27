import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateTablePage extends StatefulWidget {
  final String tableId;
  final String currentNumber;
  final String currentCapacity;

  const UpdateTablePage({
    Key? key,
    required this.tableId,
    required this.currentNumber,
    required this.currentCapacity,
  }) : super(key: key);

  @override
  _UpdateTablePageState createState() => _UpdateTablePageState();
}

class _UpdateTablePageState extends State<UpdateTablePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _numberController.text = widget.currentNumber;
    _capacityController.text = widget.currentCapacity;
  }

  void _updateTable() async {
    if (_formKey.currentState!.validate()) {
      final updatedData = {
        'number': _numberController.text.isNotEmpty
            ? _numberController.text
            : widget.currentNumber,
        'capacity': _capacityController.text.isNotEmpty
            ? _capacityController.text
            : widget.currentCapacity,
      };

      await FirebaseFirestore.instance
          .collection('tables')
          .doc(widget.tableId)
          .update(updatedData);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: Padding(
          padding: const EdgeInsets.only(top: 5, left: 58),
          child: Text(
            'Update Table',
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Table Number',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF016042)),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _numberController,
                decoration: InputDecoration(
                  labelText: 'Number',
                  hintText: 'Enter table number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a number';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Table Capacity',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF016042)),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _capacityController,
                decoration: InputDecoration(
                  labelText: 'Capacity',
                  hintText: 'Enter capacity',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a capacity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 350),
              GestureDetector(
                onTap: _updateTable,
                child: Container(
                  width: double.infinity,
                  height: 49,
                  decoration: BoxDecoration(
                    color: Color(0xFF016042),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      'Update Table',
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
      ),
    );
  }
}
