import 'package:evocapp/l10n/app_localization.dart';

import 'package:evocapp/providers/localeProvider.dart';
import 'package:evocapp/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyLanguage extends StatefulWidget {
  const MyLanguage({super.key});

  @override
  State<MyLanguage> createState() => _MyLanguageState();
}

class _MyLanguageState extends State<MyLanguage> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MyHomePage(email: ''))),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.lightGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.selectLanguage,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              _buildLanguageCard(
                context,
                language: localizations.english,
                locale: const Locale('en'),
                localeProvider: localeProvider,
              ),
              _buildLanguageCard(
                context,
                language: localizations.spanish,
                locale: const Locale('es'),
                localeProvider: localeProvider,
              ),
              _buildLanguageCard(
                context,
                language: localizations.french,
                locale: const Locale('fr'),
                localeProvider: localeProvider,
              ),
              _buildLanguageCard(
                context,
                language: localizations.german,
                locale: const Locale('de'),
                localeProvider: localeProvider,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageCard(
    BuildContext context, {
    required String language,
    required Locale locale,
    required LocaleProvider localeProvider,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          language,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: localeProvider.locale == locale
            ? const Icon(Icons.check_circle, color: Colors.green)
            : null,
        onTap: () {
          localeProvider.setLocale(locale); // Update the locale
        },
      ),
    );
  }
}
