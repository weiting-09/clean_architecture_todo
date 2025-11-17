import 'package:flutter/material.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/get_todos.dart';
import '../../domain/usecases/toggle_todo.dart';
import '../../domain/entities/todo_entity.dart';

class TodoProvider extends ChangeNotifier {
  final GetTodos getTodosUseCase;
  final AddTodo addTodoUseCase;
  final ToggleTodo toggleTodoUseCase;
  final DeleteTodo deleteTodoUseCase;

  TodoProvider({
    required this.getTodosUseCase,
    required this.addTodoUseCase,
    required this.toggleTodoUseCase,
    required this.deleteTodoUseCase,
  });

  List<TodoEntity> todos = [];
  bool isLoading = true;

  Future<void> loadTodos() async {
    isLoading = true;
    notifyListeners();

    todos = await getTodosUseCase();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addTodo(String title) async {
    await addTodoUseCase(title);
    await loadTodos();
  }

  Future<void> toggleTodo(String id) async {
    await toggleTodoUseCase(id);
    await loadTodos();
  }

  Future<void> deleteTodo(String id) async {
    await deleteTodoUseCase(id);
    await loadTodos();
  }
}
