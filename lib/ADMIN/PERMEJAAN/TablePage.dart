import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wikusamacafe/ADMIN/PERMEJAAN/ADDMEJA.dart';
import 'package:wikusamacafe/ADMIN/PERMEJAAN/UpdateTable.dart';

class TablePage extends StatefulWidget {
  const TablePage({Key? key}) : super(key: key);

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  final CollectionReference tablesCollection =
      FirebaseFirestore.instance.collection('tables');

  void _deleteTable(String id) {
    // Show confirmation dialog before deleting
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Table'),
          content: const Text('Are you sure you want to delete this table?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                tablesCollection.doc(id).delete().then((_) {
                  Navigator.of(context)
                      .pop(); // Close the dialog after deleting
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Table deleted successfully')),
                  );
                }).catchError((error) {
                  // Handle any errors that occur during deletion
                  print("Failed to delete table: $error");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to delete table')),
                  );
                });
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _editTable(String tableId, String tableNumber, String capacity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateTablePage(
          tableId: tableId,
          currentNumber: tableNumber,
          currentCapacity: capacity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: const Text(
          'Tables',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF016042),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 28),
          Expanded(
            child: StreamBuilder(
              stream: tablesCollection.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final tables = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: tables.length,
                  itemBuilder: (context, index) {
                    final table = tables[index];
                    final tableId = table.id; // Get table ID
                    final tableNumber =
                        table['number'] ?? 'N/A'; // Handle missing field
                    final capacity =
                        table['capacity'] ?? '0'; // Handle missing field

                    return Column(
                      children: [
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Number: $tableNumber',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Capacity: $capacity People',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.green),
                                    onPressed: () => _editTable(
                                        tableId,
                                        tableNumber,
                                        capacity), // Pass all required params
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => _deleteTable(
                                        table.id), // Call delete method
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Divider with the same width as the text above
                        Container(
                          width: double.infinity, // Match text width
                          child: const Divider(height: 1, color: Colors.grey),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNewTablePage()),
                );
              },
              child: Container(
                width: double.infinity,
                height: 49,
                decoration: BoxDecoration(
                  color: const Color(0xFF016042),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                  child: Text(
                    'Add New Table',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
