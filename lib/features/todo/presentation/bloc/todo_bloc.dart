import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/todo/domain/entities/todo.dart';
import 'package:todo/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:todo/features/todo/domain/usecases/param.dart';
import 'package:todo/features/todo/domain/usecases/remove_todo_usecase.dart';
import 'package:todo/features/todo/domain/usecases/update_todo_usecase.dart';

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
  final AddTodoUseCase _addTodoUseCase;
  final RemoveTodoUseCase _removeTodoUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;
  TodoBloc(
      {required AddTodoUseCase addTodoUseCase,
      required RemoveTodoUseCase removeTodoUseCase,
      required UpdateTodoUseCase updateTodoUseCase})
      : _addTodoUseCase = addTodoUseCase,
        _removeTodoUseCase = removeTodoUseCase,
        _updateTodoUseCase = updateTodoUseCase,
        super(TodoInitial(todos: testData)) {
    on<Add>((event, emit) async {
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
        emit(Fail(
            title: title,
            error: Error.duplicate,
            todos: state.todos,
            filter: state.filter));
      } else {
        final todo = Todo(title: title);
        final result = await _addTodoUseCase(param: Param(todo: event.todo));
        result.fold(
            (failure) => Fail(
                title: title,
                error: Error.duplicate,
                todos: state.todos,
                filter: state.filter), (_) {
          todos = [todo, ...todos];
          emit(Success(todos: todos, key: UniqueKey(), filter: state.filter));
        });
      }
    });
    on<Remove>((event, emit) async {
      emit(Loading(
        todos: state.todos,
      ));
      List<Todo> todos = state.todos!;
      if (todos.length != 1) {
        todos.remove(event.todo);
        final result = await _removeTodoUseCase(param: Param(todo: event.todo));
        result.fold((failure) {
          emit(Fail(
              error: Error.empty, todos: state.todos, filter: state.filter));
        }, (_) {
          emit(Success(todos: todos, filter: state.filter));
        });
      } else {
        emit(
            Fail(error: Error.empty, todos: state.todos, filter: state.filter));
      }
    });
    // TODO(ben): create update list
    on<Update>((event, emit) async {
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
        emit(Fail(
            title: newTitle,
            error: Error.duplicate,
            todos: state.todos,
            filter: state.filter));
      } else {
        event.todo.title = newTitle;
        final result =
            await _updateTodoUseCase(param: Param(todo: Todo(title: newTitle)));
        result.fold((failure) {
          emit(Fail(
              error: Error.empty, todos: state.todos, filter: state.filter));
        }, (_) {
          emit(Success(todos: state.todos, key: UniqueKey()));
        });
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
