part of 'todo_bloc.dart';

//enum StatsStatus { initial, loading, success, failure }
sealed class TodoState extends Equatable {
  const TodoState({this.key, required this.todos, this.filter});
  final List<Todo>? todos;
  final List<Todo>? filter;
  final Key? key;

  @override
  List<Object> get props => [
        todos!,
        filter!,
      ];
}

class TodoInitial extends TodoState {
  const TodoInitial(
      {super.todos = const <Todo>[], super.filter = const <Todo>[]});
}

final class Loading extends TodoState {
  const Loading({required super.todos, super.filter = const <Todo>[]});
}

final class Success extends TodoState {
  const Success(
      {super.key, required super.todos, super.filter = const <Todo>[]});
}

final class Fail extends TodoState {
  const Fail(
      {this.title,
      required this.error,
      required super.todos,
      super.filter = const <Todo>[]});
  final String? title;
  final Error error;
}
