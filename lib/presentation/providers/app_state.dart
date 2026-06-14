import 'package:flutter/material.dart';
class AppState extends ChangeNotifier { String languageCode = 'sw'; bool darkMode = false; void setLanguage(String code){languageCode=code; notifyListeners();} void toggleDark(bool v){darkMode=v; notifyListeners();} }
