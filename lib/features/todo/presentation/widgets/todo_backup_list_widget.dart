// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:todo/features/todo/presentation/bloc/bloc/todo_bloc.dart';
// import 'package:todo/features/todo/presentation/pages/todo_item.dart';

// Widget todoListWidget(
//     {required BuildContext context,
//     required TextEditingController controller}) {
//   const padding = EdgeInsets.only(
//       left: 16,
//       right: 16,
//       top: 16,
//       bottom: kBottomNavigationBarHeight + kFloatingActionButtonMargin);
//   return BlocBuilder<TodoBloc, TodoState>(
//     builder: (context, state) {
//       return controller.value.text.isEmpty
//           ? ListView.builder(
//               padding: padding,
//               itemCount: state.todos!.length * 2 - 1,
//               itemBuilder: (context, index) {
//                 if (index.isOdd) {
//                   return const Divider(
//                     indent: 6,
//                     endIndent: 6,
//                   ); // Add divider
//                 }
//                 final todoIndex = index ~/ 2;
//                 return TodoItem(todo: state.todos![todoIndex]);
//               })
//           : state.filter!.isEmpty
//               ? const Center(child: Text('No result'))
//               : ListView.builder(
//                   padding: padding,
//                   itemCount: state.filter!.length * 2 - 1,
//                   itemBuilder: (context, index) {
//                     if (index.isOdd) {
//                       return const Divider(
//                         indent: 6,
//                         endIndent: 6,
//                       ); // Add divider
//                     }
//                     final todoIndex = index ~/ 2;
//                     return TodoItem(todo: state.filter![todoIndex]);
//                   });
//     },
//   );

// }
