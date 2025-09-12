import 'package:disaster_management/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'screens/onboarding/splash_screen.dart';
import 'package:flutter/services.dart';
=======
=======
>>>>>>> News-Feed
=======
>>>>>>> Ai-Chat-Bot
=======
>>>>>>> Report-Incident-&-Real-Time-Alerts
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'screens/onboarding/splash_screen.dart';
import 'screens/navbar/home.dart';
import 'screens/navbar/alerts.dart';
import 'screens/navbar/newsfeed.dart';
import 'screens/navbar/profile.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'screens/home/contacts.dart';
import 'screens/home/knowledge_panel.dart';
import 'screens/home/privacy_policy.dart';
import 'screens/auth/logout.dart';
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> Knowledge-Panel
=======
>>>>>>> News-Feed
=======
>>>>>>> Ai-Chat-Bot
=======
>>>>>>> Report-Incident-&-Real-Time-Alerts

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor:
          Color.fromARGB(255, 255, 255, 255), // White color for status bar

      statusBarIconBrightness: Brightness.dark, // Dark icons
      statusBarBrightness: Brightness.light, // For iOS devices
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //this will remove the debug banner
      home: SplashScreen(),
=======
=======
>>>>>>> News-Feed
=======
>>>>>>> Ai-Chat-Bot
=======
>>>>>>> Report-Incident-&-Real-Time-Alerts
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission();

  // Get FCM token for this device (useful later)
  String? token = await messaging.getToken();
  print("FCM Token: $token");

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 255, 255, 255),
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en'); // default language

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('si', ''),
        Locale('ta', ''),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/emergencyAlerts': (context) => const EmergencyAlertsPage(),
        '/newsfeed': (context) => const NewsfeedPage(),
        '/contacts': (context) => ContactsPage(currentIndex: 0, onTap: (_) {}),
        '/knowledgePanel': (context) =>
            KnowledgePanelPage(currentIndex: 0, onTap: (_) {}),
        '/privacy_policy': (context) => const PrivacyPolicyPage(),
        '/profile': (context) => const ProfilePage(),
        '/logout': (context) => const LogoutScreen(),
      },
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> Knowledge-Panel
=======
>>>>>>> News-Feed
=======
>>>>>>> Ai-Chat-Bot
=======
>>>>>>> Report-Incident-&-Real-Time-Alerts
    );
  }
}
