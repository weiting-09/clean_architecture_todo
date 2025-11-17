import 'package:flutter/material.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/get_todos.dart';
import '../../domain/usecases/toggle_todo.dart';
import '../../domain/entities/todo_entity.dart';

class TodoProvider extends ChangeNotifier {
  final GetTodos getTodosUC;
  final AddTodo addTodoUC;
  final ToggleTodo toggleTodoUC;
  final DeleteTodo deleteTodoUC;

  TodoProvider({
    required this.getTodosUC,
    required this.addTodoUC,
    required this.toggleTodoUC,
    required this.deleteTodoUC,
  });

  List<TodoEntity> todos = [];
  bool isLoading = true;

  Future<void> loadTodos() async {
    isLoading = true;
    notifyListeners();

    todos = await getTodosUC();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addTodo(String title) async {
    await addTodoUC(title);
    await loadTodos();
  }

  Future<void> toggleTodo(String id) async {
    await toggleTodoUC(id);
    await loadTodos();
  }

  Future<void> deleteTodo(String id) async {
    await deleteTodoUC(id);
    await loadTodos();
  }
}
