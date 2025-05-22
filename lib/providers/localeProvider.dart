import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('en'); // Default language is English

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners(); // Notify listeners to rebuild the UI
  }
}
