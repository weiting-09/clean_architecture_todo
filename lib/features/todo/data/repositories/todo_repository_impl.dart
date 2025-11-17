import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_datasource.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource dataSource;

  TodoRepositoryImpl(this.dataSource);

  @override
  Future<List<TodoEntity>> getTodos() => dataSource.fetchTodos();

  @override
  Future<void> addTodo(String title) async {
    final todos = await dataSource.fetchTodos();
    final newTodo = TodoModel(id: DateTime.now().toString(), title: title, isDone: false);
    todos.add(newTodo);
    await dataSource.saveTodos(todos);
  }

  @override
  Future<void> toggleTodo(String id) async {
    final todos = await dataSource.fetchTodos();
    final updated = todos
        .map((t) => t.id == id ? t.copyWith(isDone: !t.isDone) : t)
        .toList();
    await dataSource.saveTodos(updated);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = await dataSource.fetchTodos();
    todos.removeWhere((t) => t.id == id);
    await dataSource.saveTodos(todos);
  }
}
