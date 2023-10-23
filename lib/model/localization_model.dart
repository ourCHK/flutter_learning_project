
import 'package:flutter/material.dart';

class LocalizationProvider extends ChangeNotifier {

  String language;

  LocalizationProvider(this.language);


  changeLanguage(String newLang) {
    language = newLang;
    notifyListeners();
  }

}