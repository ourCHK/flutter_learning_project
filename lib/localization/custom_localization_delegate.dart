import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_learning_project/localization/custom_localization.dart';

class CustomLocalizationDelegate extends LocalizationsDelegate<CustomLocalization> {

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  bool shouldReload(LocalizationsDelegate old) {
    return false;
  }

  @override
  Future<CustomLocalization> load(Locale locale) {
    print("locale:$locale");
    return SynchronousFuture<CustomLocalization> (
      CustomLocalization(locale.languageCode == "ar")
    );
  }

}