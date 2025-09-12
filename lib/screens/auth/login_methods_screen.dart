import 'package:disaster_management/screens/navbar/home.dart';
import 'package:disaster_management/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'sign_up.dart';
import 'sign_in.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipPath(
                  clipper: _InlinePolygonClipper(),
                  child: Image.asset(
                    'assets/rescueteam.png',
                    width: 390,
                    height: 400.39,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              AppLocalizations.of(context)!.welcome,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),

            const SizedBox(height: 15),

            Text(
              AppLocalizations.of(context)!.pleaseSignInOrCreate,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                height: 1.0,
                letterSpacing: 0,
                color: Color.fromARGB(179, 0, 0, 0),
              ),
            ),

            const SizedBox(height: 30),

            // Google Button
            SizedBox(
              width: 328,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  await _authService.loginWithGoogle().then((userCredential) {
                    if (userCredential != null) {
                      Fluttertoast.showToast(
                        msg: 'successfully signed in with Google',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Google sign-in failed.')),
                      );
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Color(0xFF213555)),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Image(image: AssetImage('assets/google.png')),
                    const SizedBox(width: 12),
                    Text(
                      AppLocalizations.of(context)!.signInWithGoogle,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Facebook Button
            SizedBox(
              width: 328,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Facebook login action
                  Fluttertoast.showToast(
                    msg: 'successfully signed in with FaceBook',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Color(0xFF213555)),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Image(image: AssetImage('assets/facebook.png')),
                    const SizedBox(width: 12),
                    Text(
                      AppLocalizations.of(context)!.signInWithFacebook,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Sign In button
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
                  backgroundColor: const Color(0xFF213555),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.white),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.signIn,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Register prompt
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.doNotHaveAccount,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    height: 1.0,
                    color: Color.fromARGB(179, 21, 0, 0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.registerNow,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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

class _InlinePolygonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height + 87, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
