import 'package:flutter/material.dart';

class TableList extends StatelessWidget {
  TableList({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> menuItems = [
    {
      'Number': '1 (One)',
      'Capacity': '2 People',
    },
    {
      'Number': '2 (Two)',
      'Capacity': '2 People',
    },
    {
      'Number': '3 (Three)',
      'Capacity': '4 People',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, color: Colors.grey),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item['Number'] ?? 'N/A'), // Number
              Text(item['Capacity'] ?? 'N/A'), // Capacity
            ],
          ),
        );
      },
    );
  }
}
