import '../repositories/todo_repository.dart';

class AddTodo {
  final TodoRepository repo;
  AddTodo(this.repo);

  // Future<void> call(String title) => repo.addTodo(title);

  Future<void> call(String title) {
    if (title.trim().isEmpty) {
      throw Exception("標題不得為空");
    }

    return repo.addTodo(title);
  }

}
