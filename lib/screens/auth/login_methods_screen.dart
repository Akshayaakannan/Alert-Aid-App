import 'package:disaster_management/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'sign_in.dart';

class LoginMethodsScreen extends StatefulWidget {
  const LoginMethodsScreen({super.key});

  @override
  State<LoginMethodsScreen> createState() => _LoginMethodsScreenState();
}

class _LoginMethodsScreenState extends State<LoginMethodsScreen> {
  final AuthService _authService = AuthService();
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
              'Welcome!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.0,
                color: Color(0xFF222227),
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'Lorem ipsum dolor sit amet consec Amet ut volutpat adipiscing',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                height: 1.0,
                letterSpacing: 0,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: 328,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  await _authService.loginWithGoogle().then((userCredential) {
                    if (userCredential != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Google sign-in failed.'),
                        ),
                      );
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD9D9D9),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.g_mobiledata_outlined, // Google icon
                      size: 40,
                      color: Colors.black,
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Continue with Google',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Button 2: Continue with Facebook
            SizedBox(
              width: 328,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Your button action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD9D9D9),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.facebook, // Facebook icon
                      size: 40,
                      color: Colors.blue,
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Continue with Facebook',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            SizedBox(
              width: 328,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD9D9D9),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Don't have an account? Register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Do not have an account? ",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                      color: Color.fromARGB(255, 151, 138, 138)),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to Register Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const SignUpScreen()), // Fixed this line
                    );
                  },
                  child: const Text(
                    "Register now",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 0, 0, 0),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
