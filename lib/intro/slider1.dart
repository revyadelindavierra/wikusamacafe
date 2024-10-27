import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wikusamacafe/Login/login.dart';
import 'package:wikusamacafe/intro/button.dart';
import 'package:wikusamacafe/intro/pagenya.dart';

class Slider1 extends StatefulWidget {
  const Slider1({super.key});

  @override
  _Slider1State createState() => _Slider1State();
}

class _Slider1State extends State<Slider1> {
  final PageController _controller = PageController();
  final List<String> images = [
    'lib/assets/image1.png',
    'lib/assets/image2.png',
    'lib/assets/image3.png',
  ];

  int currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentPage < images.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      _controller.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Bagian gambar
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
              children: images.map((image) {
                return Image.asset(image, fit: BoxFit.cover);
              }).toList(),
            ),
          ),

          // Page indicator
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: PageIndicator(currentPage: currentPage),
          ),

          // Teks di bawah gambar
          const Column(
            children: [
              Text(
                'Easy Make an\nTransaction',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'With WIKUSAMA Cashier.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            ],
          ),

          // Tombol login
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 50),
            child: Center(
              child: LoginButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Signinn()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
