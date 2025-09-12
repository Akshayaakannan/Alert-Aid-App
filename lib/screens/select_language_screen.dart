import 'package:disaster_management/main.dart';
import 'package:flutter/material.dart';
import 'auth/login_methods_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  String? selectedLanguage;

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
                  child: ClipPath(
                    clipper: _InlinePolygonClipper(),
                    child: Image.asset(
                      'assets/cyclone 3.jpg',
                      width: 390,
                      height: 390.39,
                      fit: BoxFit.cover,
                    ),
                  ),
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
    final isSelected = selectedLanguage == language;

    // Convert button label to locale
    Locale locale;
    switch (language) {
      case 'සිංහල':
        locale = const Locale('si');
        break;
      case 'தமிழ்':
        locale = const Locale('ta');
        break;
      default:
        locale = const Locale('en');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            selectedLanguage = language;
          });
          MyApp.of(context)?.setLocale(locale);

          // Show toast message
          final toastMessages = {
            'English': 'Language selected successfully!',
            'සිංහල': 'භාෂාව සාර්ථකව තෝරාගෙන ඇත!',
            'தமிழ்': 'மொழி தேர்ந்தெடுக்கப்பட்டது!',
          };
          Fluttertoast.showToast(
            msg: toastMessages[language] ?? 'Language selected successfully!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? const Color(0xFF213555) : Colors.white,
          foregroundColor: isSelected ? Colors.white : const Color(0xFF747474),
          minimumSize: const Size(282, 55),
          side: const BorderSide(
            color: Color(0xFF213555),
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          language,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : const Color(0xFF213555),
          ),
        ),
      ),
    );
  }
}

// Move _InlinePolygonClipper to top-level
class _InlinePolygonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 60); // Start lower on left

    // Create a smooth curved dip to the center and back up to the right
    path.quadraticBezierTo(
      size.width / 2, size.height + 87, // control point: dip deeper in center
      size.width, size.height - 60, // end point: right side up again
    );

    path.lineTo(size.width, 0); // Top right corner
    path.close(); // Complete the path

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
