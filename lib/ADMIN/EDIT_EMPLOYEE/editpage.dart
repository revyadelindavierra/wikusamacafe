import 'package:flutter/material.dart';
import 'package:wikusamacafe/ADMIN/EDIT_EMPLOYEE/Services/EmployeeService.dart';
import 'package:wikusamacafe/ADMIN/EDIT_EMPLOYEE/models/EmployeeModel.dart';

class EditUserPage extends StatefulWidget {
  final User user;

  const EditUserPage({Key? key, required this.user}) : super(key: key);

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _formKey = GlobalKey<FormState>();
  final UserService userService = UserService();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late UserRole _selectedRole;

  final Color _greenColor = const Color(0xFF016042); // Custom green color
  bool _isPasswordVisible = false; // Password visibility toggle

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _passwordController = TextEditingController(text: widget.user.password);
    _selectedRole = widget.user.role;
  }

  Future<void> _updateUser() async {
    if (_formKey.currentState!.validate()) {
      User updatedUser = User(
        id: widget.user.id,
        name: _nameController.text,
        email: _emailController.text,
        role: _selectedRole,
        password: _passwordController.text,
      );

      await userService.updateUser(updatedUser);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: _greenColor,
        title: const Center(
          child: Text(
            'New Employee',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // White icon
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
                MainAxisAlignment.start, // Align fields from the top
            children: [
              const SizedBox(height: 10),
              _buildLabel('Name'),
              const SizedBox(height: 5),
              _buildTextField(
                controller: _nameController,
                hintText: 'Enter Your New Menu Name',
              ),
              const SizedBox(height: 20),
              _buildLabel('Email'),
              const SizedBox(height: 5),
              _buildTextField(
                controller: _emailController,
                hintText: 'Enter the Price',
              ),
              const SizedBox(height: 20),
              _buildLabel('Password'),
              const SizedBox(height: 5),
              _buildPasswordField(),
              const SizedBox(height: 20),
              _buildLabel('Role'),
              const SizedBox(height: 5),
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
                decoration: InputDecoration(
                  hintText: 'Category',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(height: 150),
              Center(
                child: ElevatedButton(
                  onPressed: _updateUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _greenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Create New',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _greenColor),
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _greenColor, width: 2.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill in this field';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible, // Toggle password visibility
      decoration: InputDecoration(
        hintText: 'Enter the Price',
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _greenColor),
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _greenColor, width: 2.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: _greenColor,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible; // Toggle state
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        return null;
      },
    );
  }
}
