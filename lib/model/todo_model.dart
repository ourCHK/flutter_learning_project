class Todo {

  String description;

  Todo(this.description);

  Todo.fromMap(Map<String, dynamic> map): this(map['description'] as String);

}