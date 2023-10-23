import 'package:flutter/cupertino.dart';

class CustomLocalization {

  bool isAr = false;

  CustomLocalization(this.isAr);

  static CustomLocalization of(BuildContext context) {
    return Localizations.of<CustomLocalization>(context, CustomLocalization)!;
  }

  String get title {
    return isAr ? "التعريب" : "Localizations";
  }

  String get changeLanguage {
    return isAr ? "تغيير اللغة" : "ChangeLanguage";
  }

}