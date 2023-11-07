import 'package:flutter/material.dart';
import 'package:flutter_learning_project/localization/custom_localization.dart';
import 'package:flutter_learning_project/providers/config_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/auto_gen/app_localizations.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocalization.of(context).title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.helloWorld),
            Consumer(builder: (context,ref,child){
              return ElevatedButton(
                  onPressed: (){
                    ref.read(languageProvider.notifier).changeLanguage();
                  },
                  child: Text(CustomLocalization.of(context).changeLanguage)
              );
            })
          ],
        ),
      ),
    );
  }

  // changeLanguage(LocalizationProvider locationProvider) {
  //   String newLanguage;
  //   if (locationProvider.language == 'en') {
  //     newLanguage = "ar";
  //   } else {
  //     newLanguage = "en";
  //   }
  //   locationProvider.changeLanguage(newLanguage);
  // }

}
