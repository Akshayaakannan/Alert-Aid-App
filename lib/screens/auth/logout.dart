import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:disaster_management/screens/onboarding/splash_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  bool _isLoggingOut = false;

  @override
  void initState() {
    super.initState();
    _logoutUser();
  }

  Future<void> _logoutUser() async {
    setState(() {
      _isLoggingOut = true;
    });

    try {
      await FirebaseAuth.instance.signOut();

      if (!mounted) return;

      Fluttertoast.showToast(
        msg: 'Log Out Successful\nSee you soon!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen()),
        (route) => false,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout failed: $e')),
        );
        setState(() {
          _isLoggingOut = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoggingOut
            ? const CircularProgressIndicator()
            : const Text('Logging out...'),
      ),
    );
  }
}
