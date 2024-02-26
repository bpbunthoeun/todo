import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/domain/entities/todo.dart';
import 'package:todo/features/todo/presentation/bloc/bloc/todo_bloc.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({super.key, required this.title, this.todo});
  final String title;
  final Todo? todo;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: widget.todo == null ? '' : widget.todo!.title);
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: kBottomNavigationBarHeight + kFloatingActionButtonMargin);
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is Success && state.key != null) {
          Navigator.pop(context);
        } else if (state is Failure) {
          _controller.text = state.title!;
        }
      },
      child: Column(
        children: [
          Container(
            height: kToolbarHeight,
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Stack(alignment: Alignment.center, children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close)),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              autofocus: true,
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Todo',
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  final todo = Todo(title: value);
                  if (widget.todo != null) {
                    context.read<TodoBloc>().add(Update(
                          newTitle: value,
                          todo: widget.todo!,
                        ));
                  } else {
                    context.read<TodoBloc>().add(Add(
                          todo: todo,
                        ));
                  }

                  _controller.clear();
                }
                //Navigator.pop(context);
              },
              onChanged: (value) {
                context.read<TodoBloc>().add(Filter(text: value));
              },
            ),
          ),
          widget.title == 'Update'
              ? const SizedBox()
              : Expanded(
                  child: BlocBuilder<TodoBloc, TodoState>(
                    builder: (context, state) {
                      return _controller.value.text.isEmpty
                          ? const Center(
                              child: Text('Create your new task here'),
                            )
                          : state.filter!.isEmpty
                              ? const Center(
                                  child: Text(
                                      'No result. Create a new one instead'))
                              : ListView.builder(
                                  padding: padding,
                                  itemCount: state.filter!.length * 2 - 1,
                                  itemBuilder: (context, index) {
                                    if (index.isOdd) {
                                      return const Divider(
                                        indent: 6,
                                        endIndent: 6,
                                      ); // Add divider
                                    }
                                    final todoIndex = index ~/ 2;
                                    return ListTile(
                                      title:
                                          Text(state.filter![todoIndex].title),
                                    );
                                    //TodoItem(todo: state.filter![todoIndex]);
                                  });
                    },
                  ),
                )
        ],
      ),
      // child: Scaffold(
      //   appBar: AppBar(
      //     title: Text(widget.title),
      //     automaticallyImplyLeading: false,
      //     actions: [
      //       Padding(
      //         padding: const EdgeInsets.only(right: 16),
      //         child: IconButton(
      //             onPressed: () => Navigator.pop(context),
      //             icon: const Icon(Icons.close)),
      //       )
      //     ],
      //   ),
      //   body: Column(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.all(16),
      //         child: TextField(
      //           autofocus: true,
      //           controller: _controller,
      //           decoration: InputDecoration(
      //             border: const OutlineInputBorder(),
      //             labelText: widget.todo == null ? 'Todo' : widget.todo!.title,
      //           ),
      //           onSubmitted: (value) {
      //             if (value.isNotEmpty) {
      //               final todo = Todo(title: value);
      //               if (widget.todo != null) {
      //                 context.read<TodoBloc>().add(Update(
      //                       newTitle: value,
      //                       todo: widget.todo!,
      //                     ));
      //               } else {
      //                 context.read<TodoBloc>().add(Add(
      //                       todo: todo,
      //                     ));
      //               }

      //               _controller.clear();
      //             }
      //             //Navigator.pop(context);
      //           },
      //           onChanged: (value) {
      //             context.read<TodoBloc>().add(Filter(text: value));
      //           },
      //         ),
      //       ),
      //       widget.title == 'Update'
      //           ? const SizedBox()
      //           : Expanded(
      //               child: BlocBuilder<TodoBloc, TodoState>(
      //                 builder: (context, state) {
      //                   return _controller.value.text.isEmpty
      //                       ? const Center(
      //                           child: Text('Create your new task here'),
      //                         )
      //                       : state.filter!.isEmpty
      //                           ? const Center(
      //                               child: Text(
      //                                   'No result. Create a new one instead'))
      //                           : ListView.builder(
      //                               padding: padding,
      //                               itemCount: state.filter!.length * 2 - 1,
      //                               itemBuilder: (context, index) {
      //                                 if (index.isOdd) {
      //                                   return const Divider(
      //                                     indent: 6,
      //                                     endIndent: 6,
      //                                   ); // Add divider
      //                                 }
      //                                 final todoIndex = index ~/ 2;
      //                                 return ListTile(
      //                                   title: Text(
      //                                       state.filter![todoIndex].title),
      //                                 );
      //                                 //TodoItem(todo: state.filter![todoIndex]);
      //                               });
      //                 },
      //               ),
      //             )
      //     ],
      //   ),

      // ),
    );
  }
}
