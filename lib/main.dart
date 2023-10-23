import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learning_project/localization/custom_localization_delegate.dart';
import 'package:flutter_learning_project/model/localization_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'entry.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(ChangeNotifierProvider(
    create: (context) => LocalizationProvider('en'),
    child: const MyLearningApp(),
  ));
}

class MyLearningApp extends StatefulWidget {
  const MyLearningApp({super.key});

  @override
  State createState() {
    return _MyLearningAppState();
  }
}

class _MyLearningAppState extends State<MyLearningApp> {
  // String _languageCode = 'ar';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FlutterLearningApp",
      theme: ThemeData(),
      home: Entry(),
      localizationsDelegates: [
        ...GlobalMaterialLocalizations.delegates,
        CustomLocalizationDelegate()
      ],
      supportedLocales: const [
        Locale('en', "US"), //美国英语
        Locale('ar', ''), //阿拉伯语
      ],
      locale: Locale(Provider.of<LocalizationProvider>(context).language, ''),
    );
  }
}
