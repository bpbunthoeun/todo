import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/domain/entities/todo.dart';
import 'package:todo/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo/features/todo/presentation/widgets/input_widget.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16),
      title: Text(
        todo.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: todo.completed
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => InputWidget(
              //         title: 'Update',
              //         todo: todo,
              //       ),
              //     ));
              //_showEditDialog(context, todo);
              showModalBottomSheet(
                  context: context,
                  builder: ((context) => InputWidget(
                        title: 'Update',
                        todo: todo,
                      )));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<TodoBloc>().add(Remove(todo: todo));
            },
          ),
          IconButton(
            icon: Icon(todo.completed
                ? Icons.check_box
                : Icons.check_box_outline_blank),
            onPressed: () {
              context.read<TodoBloc>().add(ToggleComplete(todo: todo));
            },
          ),
        ],
      ),
    );
  }
}
