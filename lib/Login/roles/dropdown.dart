import 'package:flutter/material.dart';


class RoleDropdown extends StatefulWidget {
  final Function(String?) onChanged;

  const RoleDropdown({required this.onChanged, super.key, String? value});

  @override
  _RoleDropdownState createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {
  final List<String> _roles = ['admin', 'cashier', 'manager'];
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 22),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF016042),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: const Text(
              "Choose Your Roles",
              style: TextStyle(
                color: Color(0xFFACACAC),
              ),
            ),
            value: _selectedRole,
            icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF016042)),
            iconSize: 24,
            isExpanded: true,
            items: _roles.map((String role) {
              return DropdownMenuItem<String>(
                value: role,
                child: Text(role),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedRole = newValue;
              });
              widget.onChanged(newValue);
            },
          ),
        ),
      ),
    );
  }
}
