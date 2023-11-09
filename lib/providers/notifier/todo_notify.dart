import 'package:dio/dio.dart';
import 'package:flutter_learning_project/model/todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoNotify extends AutoDisposeAsyncNotifier<List<Todo>> {

  @override
  Future<List<Todo>> build() async{
    return [
    ];
  }

  Future<void> getTodoList() async {
    Dio dio = Dio();
    var response = await dio.get("http://192.168.136.235:3000/mock/349/getList");
    var data = (response as List)
    .cast<Map<String,dynamic>>()
    .map((e) => Todo.fromMap(e))
    .toList();

    state = AsyncData(data);
  }

}