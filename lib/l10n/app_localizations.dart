import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale; const AppLocalizations(this.locale);
  static const supportedLocales = [Locale('sw'), Locale('en')];
  static const delegate = _Delegate();
  static AppLocalizations of(BuildContext context) => Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  static const _values = {
    'sw': {'app':'Mama Group','login':'Ingia','dashboard':'Dashibodi','members':'Wanachama','savings':'Akiba','loans':'Mikopo','social':'Mfuko wa Jamii','meetings':'Mikutano','reports':'Ripoti','settings':'Mipangilio','totalMembers':'Jumla ya Wanachama','totalSavings':'Jumla ya Akiba','totalLoans':'Jumla ya Mikopo','fundBalance':'Salio la Mfuko','save':'Hifadhi','search':'Tafuta'},
    'en': {'app':'Mama Group','login':'Login','dashboard':'Dashboard','members':'Members','savings':'Savings','loans':'Loans','social':'Social Fund','meetings':'Meetings','reports':'Reports','settings':'Settings','totalMembers':'Total Members','totalSavings':'Total Savings','totalLoans':'Total Loans','fundBalance':'Social Fund Balance','save':'Save','search':'Search'},
  };
  String t(String key) => _values[locale.languageCode]?[key] ?? _values['sw']![key] ?? key;
}
class _Delegate extends LocalizationsDelegate<AppLocalizations> { const _Delegate(); @override bool isSupported(Locale locale)=>['sw','en'].contains(locale.languageCode); @override Future<AppLocalizations> load(Locale locale) async=>AppLocalizations(locale); @override bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old)=>false; }
