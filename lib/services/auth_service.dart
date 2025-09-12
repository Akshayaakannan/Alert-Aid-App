import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Listen for token refresh and update Firestore
  void startTokenRefreshListener(String userId) {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      await _firestore.collection('users').doc(userId).set({
        'fcmToken': newToken,
      }, SetOptions(merge: true));
    });
  }

  // Save current FCM token
  Future<void> saveUserToken(String userId) async {
    String? token = await FirebaseMessaging.instance.getToken();
    await _firestore.collection('users').doc(userId).set({
      'fcmToken': token,
    }, SetOptions(merge: true));
  }

  Future<void> sendPasswordResetLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'createdAt': Timestamp.now(),
        });

        await saveUserToken(user.uid); // Save initial token
        startTokenRefreshListener(user.uid); // Listen for token refresh

        Fluttertoast.showToast(
          msg: "Sign up successful!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "User creation failed. Please try again.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  Future<User?> signin({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        Fluttertoast.showToast(
          msg: 'successfully signed in with Google',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        await saveUserToken(user.uid);
        startTokenRefreshListener(user.uid);
      }

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        await saveUserToken(user.uid);
        startTokenRefreshListener(user.uid);
      }

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Facebook login - update as needed (currently Google sign-in fallback)
  Future<UserCredential?> loginWithFaceBook() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;
      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

      final UserCredential userCredential =
          await _auth.signInWithCredential(cred);

      // Save token & listen for refresh
      await saveUserToken(userCredential.user!.uid);
      startTokenRefreshListener(userCredential.user!.uid);

      return userCredential;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Facebook sign-in failed. Please try again.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      return null;
    }
  }

  // Twitter login - update as needed (currently Google sign-in fallback)
  Future<UserCredential?> loginWithTwitter() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;
      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

      final UserCredential userCredential =
          await _auth.signInWithCredential(cred);

      // Save token & listen for refresh
      await saveUserToken(userCredential.user!.uid);
      startTokenRefreshListener(userCredential.user!.uid);

      return userCredential;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Twitter sign-in failed. Please try again.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      return null;
    }
  }
}
