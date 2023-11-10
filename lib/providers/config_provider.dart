import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning_project/model/activity_model.dart';
import 'package:flutter_learning_project/model/todo_model.dart';
import 'package:flutter_learning_project/providers/notifier/custom_async_notify.dart';
import 'package:flutter_learning_project/providers/notifier/custom_auto_dispose_notify.dart';
import 'package:flutter_learning_project/providers/notifier/language_notify.dart';
import 'package:flutter_learning_project/providers/notifier/listen_notify.dart';
import 'package:flutter_learning_project/providers/notifier/theme_nofity.dart';
import 'package:flutter_learning_project/providers/notifier/todo_notify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///简单同步provider
final simpleProvider = Provider<String>((ref) => "get This from SimpleProvider");

///简单带单参数provider
final simpleFamilyProvider = Provider.family<String,int>((ref,value){
  return "This is the value you input:$value now:${DateTime.now()}";
});

final simpleRecordsFamilyProvider = Provider.family<String,({int a,int b})>((ref,records) {
  return "this is the family with records,the first a is:${records.a} and the second b is ${records.b} and their sum is ${records.a+records.b}";
});

///简单异步Provider
final simpleAsyncProvider = AsyncNotifierProvider<CustomAsyncNotify,String>(()=> CustomAsyncNotify());

///简单异步自动取消订阅
final simpleAutoDisposeAsyncProvider = AutoDisposeAsyncNotifierProvider<CustomAutoDisposeNotify,String>(()=> CustomAutoDisposeNotify());

///监听数据变化的provider
final listenProvider = NotifierProvider<ListenNotify,int>(()=>ListenNotify());

final combineSubAsyncProvider1 = FutureProvider<String>((ref) async {
  await Future.delayed(const Duration(seconds: 2));
  return "CombineSubResult1";
});

///一个provider等待另外一个provider的执行情况
final combineAsyncProvider = FutureProvider<String>((ref) async {
  final futureResult = await ref.watch(combineSubAsyncProvider1.future);
  final finalResult = ref.watch(simpleFamilyProvider(9999));
  return futureResult + finalResult;
});


///语言的provider
final languageProvider = NotifierProvider<LanguageNotify,String>(()=>LanguageNotify());


///主题的provider
final themeProvider = NotifierProvider<ThemeNotify,ThemeData>(()=>ThemeNotify());

final httpProvider = FutureProvider.autoDispose((ref) async {
  final dio = Dio();
  final response = await dio.get('https://www.boredapi.com/api/activity?participants=1');
  print(response.data);
  return ActivityModel.fromMap(response.data);
});

final todoProvider = AutoDisposeAsyncNotifierProvider<TodoNotify,List<Todo>>(()=>TodoNotify());