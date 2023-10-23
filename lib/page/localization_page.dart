import 'package:flutter/material.dart';
import 'package:flutter_learning_project/localization/custom_localization.dart';
import 'package:flutter_learning_project/model/localization_model.dart';
import 'package:flutter_learning_project/theme/theme_config.dart';
import 'package:provider/provider.dart';

class LocalizationPage extends StatefulWidget {
  const LocalizationPage({super.key});

  @override
  State createState() {
    return _LocalizationPageState();
  }
}

class _LocalizationPageState extends State<LocalizationPage> {


  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LocalizationProvider>(context,listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocalization.of(context).title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  changeLanguage(languageProvider);
                },
                child: Text(CustomLocalization.of(context).changeLanguage)
            )
          ],
        ),
      ),
    );
  }

  changeLanguage(LocalizationProvider locationProvider) {
    String newLanguage;
    if (locationProvider.language == 'en') {
      newLanguage = "ar";
    } else {
      newLanguage = "en";
    }
    locationProvider.changeLanguage(newLanguage);
  }

}
