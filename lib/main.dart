import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/todo/data/datasources/todo_local_datasource.dart';
import 'features/todo/data/repositories/todo_repository_impl.dart';
import 'features/todo/domain/usecases/add_todo.dart';
import 'features/todo/domain/usecases/delete_todo.dart';
import 'features/todo/domain/usecases/get_todos.dart';
import 'features/todo/domain/usecases/toggle_todo.dart';
import 'features/todo/presentation/pages/todo_page.dart';
import 'features/todo/presentation/provider/todo_provider.dart';

void main() {
  final ds = TodoLocalDataSourceImpl();
  final repo = TodoRepositoryImpl(ds);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TodoProvider(
            getTodosUC: GetTodos(repo),
            addTodoUC: AddTodo(repo),
            toggleTodoUC: ToggleTodo(repo),
            deleteTodoUC: DeleteTodo(repo),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TodoPage(),
    );
  }
}
