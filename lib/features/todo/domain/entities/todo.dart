import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Todo extends Equatable {
  String title;
  bool completed;

  Todo({required this.title, this.completed = false});

  @override
  List<Object?> get props => [title, completed];
}
