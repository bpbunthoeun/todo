import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo/features/todo/presentation/widgets/input_widget.dart';
import 'package:todo/features/todo/presentation/widgets/todo_list_widget.dart';
import 'package:todo/features/todo/presentation/widgets/warring.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String title = 'TODO';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocListener<TodoBloc, TodoState>(
      listener: (BuildContext context, TodoState state) {
        if (state is Fail) {
          wanning(context: context, failure: state);
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar.medium(
              title: Text(
                  '$title ${context.watch<TodoBloc>().state.todos!.length}'),
              flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                children: [
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: textTheme.displayMedium,
                    ),
                  )),
                ],
              )),
            ),
            const SliverFillRemaining(
              child: Card(child: TodoListPage()),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) => const InputWidget(title: 'Add new'));
          },
          label: const Text('New'),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
