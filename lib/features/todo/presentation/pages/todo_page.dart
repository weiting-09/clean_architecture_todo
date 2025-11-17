import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/todo_provider.dart';
import '../widgets/todo_item_widget.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TodoProvider>().loadTodos());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TodoProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Todo List")),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Add a todo",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      provider.addTodo(controller.text);
                      controller.clear();
                    }
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.todos.length,
              itemBuilder: (context, index) {
                final todo = provider.todos[index];
                return TodoItemWidget(
                  todo: todo,
                  onToggle: () => provider.toggleTodo(todo.id),
                  onDelete: () => provider.deleteTodo(todo.id),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
