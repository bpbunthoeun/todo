import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/presentation/bloc/bloc/todo_bloc.dart';
import 'package:todo/features/todo/presentation/pages/todo_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: kBottomNavigationBarHeight + kFloatingActionButtonMargin);
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return ListView.builder(
            padding: padding,
            itemCount: state.todos!.length * 2 - 1,
            itemBuilder: (context, index) {
              if (index.isOdd) {
                return const Divider(
                  indent: 6,
                  endIndent: 6,
                );
              }
              final todoIndex = index ~/ 2;
              return TodoItem(todo: state.todos![todoIndex]);
            });
      },
    );
  }
}
