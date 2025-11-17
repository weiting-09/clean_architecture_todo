import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> fetchTodos();
  Future<void> saveTodos(List<TodoModel> todos);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  static const key = "TODOS_KEY";

  @override
  Future<List<TodoModel>> fetchTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);

    if (jsonString == null) return [];

    final list = json.decode(jsonString) as List;
    return list.map((e) => TodoModel.fromMap(e)).toList();
  }

  @override
  Future<void> saveTodos(List<TodoModel> todos) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      key,
      json.encode(todos.map((e) => e.toMap()).toList()),
    );
  }
}
