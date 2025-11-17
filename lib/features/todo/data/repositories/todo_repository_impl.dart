import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_datasource.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource ds;

  TodoRepositoryImpl(this.ds);

  @override
  Future<List<TodoEntity>> getTodos() => ds.fetchTodos();

  @override
  Future<void> addTodo(String title) async {
    final todos = await ds.fetchTodos();
    final newTodo = TodoModel(id: DateTime.now().toString(), title: title, isDone: false);
    todos.add(newTodo);
    await ds.saveTodos(todos);
  }

  @override
  Future<void> toggleTodo(String id) async {
    final todos = await ds.fetchTodos();
    final updated = todos
        .map((t) => t.id == id ? t.copyWith(isDone: !t.isDone) : t)
        .toList();
    await ds.saveTodos(updated);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = await ds.fetchTodos();
    todos.removeWhere((t) => t.id == id);
    await ds.saveTodos(todos);
  }
}
