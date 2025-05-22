import 'package:evocapp/l10n/app_localization.dart';
import 'package:evocapp/providers/localeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Add this import
import 'package:provider/provider.dart'; // Add this import
import 'package:evocapp/services/sync_user.dart';

import 'screens/startup.dart';
import 'screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const String email = '';
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(), // Provide the LocaleProvider
      child: const MyApp(email: email),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String email;
  const MyApp({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: localeProvider.locale, // Use the selected locale
      localizationsDelegates: const [
        AppLocalizations.delegate, // Generated localization delegate
        GlobalMaterialLocalizations.delegate, // Material localization
        GlobalWidgetsLocalizations.delegate, // Widgets localization
        GlobalCupertinoLocalizations.delegate, // Cupertino localization
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
        Locale('fr'), // French
        Locale('de'), // German
      ],
      home: MyStartup(email: email),
      routes: {
        '/homepage': (context) => MyHomePage(email: email),
      },
    );
  }
}
