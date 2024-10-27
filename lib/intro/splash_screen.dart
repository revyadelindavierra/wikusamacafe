import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:wikusamacafe/intro/lingkaran_element.dart';
import 'package:wikusamacafe/intro/slider1.dart';

class SplashScreenn extends StatelessWidget {
  const SplashScreenn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFF016042),
          ),
          const lingkaran_element(),
          Center(
            child: AnimatedSplashScreen(
              splash: 'lib/assets/logo_rmv.png',
              splashIconSize: 9800, 
              nextScreen:  const Slider1(),
              splashTransition: SplashTransition.sizeTransition,
              backgroundColor: Colors.transparent, 
            ),
          ),
        ],
      ),
    );
  }
}
