import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xogame/LayOuts/MainScreens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // to Make timer when end do an action
  // to make splash Screen
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainScreens())));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color.fromARGB(255, 70, 163, 249),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            width: double.infinity,
            image: AssetImage('assets/images/SplashScreen.png'),
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: LinearProgressIndicator(
              color: Colors.amber[500],
              minHeight: 5,
              backgroundColor: const Color.fromARGB(255, 70, 163, 249),
            ),
          ),
        ],
      ),
    ));
  }
}
