import 'package:flutter_learning_project/providers/notifier/language_notify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageProvider = NotifierProvider<LanguageNotify,String>(()=>LanguageNotify());