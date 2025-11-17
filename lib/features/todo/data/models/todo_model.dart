import '../../domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  const TodoModel({
    required super.id,
    required super.title,
    required super.isDone,
  });

  TodoModel copyWith({String? title, bool? isDone}) {
    return TodoModel(
      id: id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      isDone: map['isDone'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'isDone': isDone,
  };
}
