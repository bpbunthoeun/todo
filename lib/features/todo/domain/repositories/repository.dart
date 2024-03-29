import 'package:dartz/dartz.dart';
import 'package:todo/core/failure/app_failure.dart';
import 'package:todo/features/todo/domain/usecases/param.dart';

abstract class Repository {
  Future<Either<Failure, void>> addTodo({required Param param});
  Future<Either<Failure, void>> removeTodo({required Param param});
    Future<Either<Failure, void>> updateTodo({required Param param});

  //updateTodo
}
