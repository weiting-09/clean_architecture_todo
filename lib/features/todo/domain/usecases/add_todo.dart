import '../repositories/todo_repository.dart';

class AddTodo {
  final TodoRepository repo;
  AddTodo(this.repo);

  Future<void> call(String title) => repo.addTodo(title);
}
