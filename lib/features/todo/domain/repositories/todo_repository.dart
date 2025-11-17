import '../entities/todo_entity.dart';
abstract class TodoRepository {
  Future<List<TodoEntity>> getTodos();
  Future<void> addTodo(String title);
  Future<void> toggleTodo(String id);
  Future<void> deleteTodo(String id);
}
