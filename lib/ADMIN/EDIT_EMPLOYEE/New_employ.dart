import 'package:flutter/material.dart';
import 'package:wikusamacafe/ADMIN/EDIT_EMPLOYEE/Services/EmployeeService.dart';
import 'package:wikusamacafe/ADMIN/EDIT_EMPLOYEE/models/EmployeeModel.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  final UserService userService = UserService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController(); // Controller untuk password
  UserRole _selectedRole = UserRole.cashier;

  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      User newUser = User(
        id: '', // Firestore akan secara otomatis memberi ID
        name: _nameController.text,
        email: _emailController.text,
        role: _selectedRole,
        password: _passwordController.text, // Ambil password dari controller
      );

      await userService.addUser(newUser);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true, // Menyembunyikan input password
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<UserRole>(
                value: _selectedRole,
                items: UserRole.values.map((UserRole role) {
                  return DropdownMenuItem<UserRole>(
                    value: role,
                    child: Text(role.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (UserRole? newValue) {
                  setState(() {
                    _selectedRole = newValue!;
                  });
                },
                decoration: InputDecoration(labelText: 'Role'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveUser,
                child: Text('Save User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
