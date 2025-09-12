import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcome => 'welcome!';

  @override
  String get pleaseSignInOrCreate => 'Please sign in to your account or\n create a new account';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get signInWithFacebook => 'Sign in with Facebook';

  @override
  String get doNotHaveAccount => 'Do not have an account?';

  @override
  String get registerNow => 'Register now';

  @override
  String get signIn => 'Sign In';
}
