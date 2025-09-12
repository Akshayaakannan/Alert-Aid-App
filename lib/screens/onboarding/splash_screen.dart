import 'package:flutter/material.dart';
import 'dart:async'; // Import the timer package
import '../select_language_screen.dart'; // Import the next page after splash

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to the next page after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SelectLanguageScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // Added SafeArea to prevent UI overlap
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/gallery.png',
                  width: 133,
                  height: 133,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
