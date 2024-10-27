import 'package:flutter/material.dart';
import 'package:wikusamacafe/Login/roles/roles.dart';

class Signinn extends StatefulWidget {
  const Signinn({super.key});

  @override
  State<Signinn> createState() => _SigninnState();
}

class _SigninnState extends State<Signinn> {
  bool _isPasswordVisible = false;
  late List<FocusNode> _focusNodes;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isFieldsValid = false;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(2, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateFields() {
    setState(() {
      _isFieldsValid = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFF016042)),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 65, left: 28),
                  child: const Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "Welcome\nBack",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 43,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 45),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                padding: const EdgeInsets.only(left: 15),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20, top: 45),
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              color: Color.fromARGB(255, 41, 30, 30),
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  controller: _emailController,
                                  focusNode: _focusNodes[0],
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                  ),
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(_focusNodes[1]);
                                  },
                                  onChanged: (_) {
                                    _validateFields();
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  controller: _passwordController,
                                  focusNode: _focusNodes[1],
                                  obscureText: !_isPasswordVisible,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  onChanged: (_) {
                                    _validateFields();
                                  },
                                ),
                              ),
                              const SizedBox(height: 21),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                          color: Color(0xFF016042),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 190),
                              ElevatedButton(
                                onPressed: _isFieldsValid ? _login : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF016042),
                                  fixedSize: const Size(300, 48),
                                ),
                                child: const Text(
                                  'Sign in',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 19),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

  void _login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  const Roless()),
    );
  }
}
