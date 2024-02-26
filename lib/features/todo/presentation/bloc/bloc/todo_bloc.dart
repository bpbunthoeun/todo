import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/todo/domain/entities/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

enum Error { duplicate, empty }

final testData = [
  Todo(title: 'title0'),
  Todo(title: 'title1'),
  Todo(title: 'title2'),
  Todo(title: 'title3'),
  Todo(title: 'title4'),
  Todo(title: 'title5'),
  Todo(title: 'title6'),
  Todo(title: 'title5'),
  Todo(title: 'title6'),
  Todo(title: 'title5'),
  Todo(title: 'title6'),
  Todo(title: 'title5'),
  Todo(title: 'title6')
];

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial(todos: testData)) {
    on<Add>((event, emit) {
      emit(Loading(todos: state.todos, filter: state.filter));
      // make sure that there is no leading or trilling space.
      // and prevent the empty space input
      final title = event.todo.title.trim();
      List<Todo> todos = state.todos!;
      if (todos.any(
            (element) => element.title.toLowerCase() == title.toLowerCase(),
          ) ||
          title.isEmpty) {
        // emit the failure and alert to the user
        emit(Failure(
            title: title,
            error: Error.duplicate,
            todos: state.todos,
            filter: state.filter));
      } else {
        final todo = Todo(title: title);
        todos = [todo, ...todos];
        emit(Success(todos: todos, key: UniqueKey(), filter: state.filter));
      }
    });
    on<Remove>((event, emit) {
      emit(Loading(
        todos: state.todos,
      ));
      List<Todo> todos = state.todos!;
      if (todos.length != 1) {
        todos.remove(event.todo);

        emit(Success(todos: todos, filter: state.filter));
      } else {
        emit(Failure(
            error: Error.empty, todos: state.todos, filter: state.filter));
      }
    });
    on<Update>((event, emit) {
      emit(Loading(todos: state.todos, filter: state.filter));
      // make sure that there is no leading or trilling space.
      // and prevent the empty space input
      final newTitle = event.newTitle.trim();
      List<Todo> todos = state.todos!;
      if (todos.any(
            (element) => element.title.toLowerCase() == newTitle.toLowerCase(),
          ) ||
          newTitle.isEmpty) {
        // emit the failure and alert to the user
        emit(Failure(
            title: newTitle,
            error: Error.duplicate,
            todos: state.todos,
            filter: state.filter));
      } else {
        event.todo.title = newTitle;
        emit(Success(todos: state.todos, key: UniqueKey()));
      }
    });
    on<ToggleComplete>((event, emit) {
      emit(Loading(todos: state.todos, filter: state.filter));
      event.todo.completed = !event.todo.completed;
      emit(Success(todos: state.todos, filter: state.filter));
    });
    on<Filter>((event, emit) {
      emit(Loading(todos: state.todos));
      // final filter = state.todos!
      //     .where((todo) => todo.title.contains(event.text))
      //     .toList();
      final filter =
          state.todos!.where((todo) => todo.title == event.text).toList();
      emit(Success(todos: state.todos, filter: filter));
    });
  }
}
