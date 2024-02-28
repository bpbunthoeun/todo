part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

final class Add extends TodoEvent {
  final Todo todo;

  const Add({
    required this.todo,
  });
}

final class Remove extends TodoEvent {
  final Todo todo;

  const Remove({required this.todo});
}

final class Update extends TodoEvent {
  final String newTitle;
  final Todo todo;

  const Update({required this.todo, required this.newTitle});
}

final class ToggleComplete extends TodoEvent {
  final Todo todo;

  const ToggleComplete({required this.todo});
}

final class Filter extends TodoEvent {
  final String text;

  const Filter({required this.text});
}
