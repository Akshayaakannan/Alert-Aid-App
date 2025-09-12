import 'package:flutter/material.dart';
import 'auth/login_methods_screen.dart'; // Import the LoginMethodsScreen file

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: Image.asset(
                    'assets/Polygon 6.png',
                    width: 390,
                    height: 400.39,
                    fit: BoxFit.cover,
                  ),
                ),
                Image.asset(
                  'assets/gallery.png',
                  width: 56,
                  height: 56,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Title
            const Text(
              'Select Language',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.0,
              ),
            ),

            const SizedBox(height: 15),

            // Language Selection Buttons
            _languageButton('English'),
            _languageButton('සිංහල'),
            _languageButton('தமிழ்'),

            const SizedBox(height: 15),

            // Next Button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginMethodsScreen()),
                );
              },
              child: Image.asset(
                'assets/Group 3.png',
                width: 60,
                height: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Language Button Function
  Widget _languageButton(String language) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD9D9D9),
          foregroundColor: Colors.black,
          minimumSize: const Size(282, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          language,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF747474),
          ),
        ),
      ),
    );
  }
}
