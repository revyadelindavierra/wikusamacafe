import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wikusamacafe/Navbar/Navbar_Ad.dart';
import 'package:wikusamacafe/intro/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    runApp(const MyApp());
  } catch (e) {
    print('Error initializing Firebase: $e');
    runApp(ErrorApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get selectedItems => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreenn(),
    );
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Failed to initialize Firebase.'),
        ),
      ),
    );
  }
}
