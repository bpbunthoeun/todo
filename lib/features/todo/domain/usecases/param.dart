import 'package:equatable/equatable.dart';
import 'package:todo/features/todo/domain/entities/todo.dart';

class Param extends Equatable {
  final Todo? todo;

  const Param({this.todo});
  @override
  List<Object?> get props => [todo];
}

class NoParam extends Param {}

// class AddParam extends Param {}

// class UpdateParam extends Param {}

// class DeleteParam extends Param {}
