// DO NOT EDIT. This is code generated via package:flutter_gen/gen_l10n.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

/// A class providing localized strings for the app.
class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Add your localized strings here
  String get appTitle {
    return Intl.message(
      'Language Settings',
      name: 'appTitle',
      desc: 'Title of the app',
      locale: locale.toString(),
    );
  }

  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: 'Prompt to select a language',
      locale: locale.toString(),
    );
  }

  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: 'English language',
      locale: locale.toString(),
    );
  }

  String get spanish {
    return Intl.message(
      'Spanish',
      name: 'spanish',
      desc: 'Spanish language',
      locale: locale.toString(),
    );
  }

  String get french {
    return Intl.message(
      'French',
      name: 'french',
      desc: 'French language',
      locale: locale.toString(),
    );
  }

  String get german {
    return Intl.message(
      'German',
      name: 'german',
      desc: 'German language',
      locale: locale.toString(),
    );
  }

  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: 'Save button text',
      locale: locale.toString(),
    );
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'fr', 'de'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
