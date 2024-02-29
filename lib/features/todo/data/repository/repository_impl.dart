import 'package:dartz/dartz.dart';
import 'package:todo/core/exception/app_exception.dart';
import 'package:todo/core/failure/app_failure.dart';
import 'package:todo/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:todo/features/todo/domain/repositories/repository.dart';
import 'package:todo/features/todo/domain/usecases/param.dart';

class RepositoryImpl implements Repository {
  final TodoRemoteDataSource _todoRemoteDataSource;

  RepositoryImpl({required TodoRemoteDataSource todoRemoteDataSource})
      : _todoRemoteDataSource = todoRemoteDataSource;

  @override
  Future<Either<Failure, void>> addTodo({required Param param}) async {
    try {
      return Right(await _todoRemoteDataSource.addTodo(param: param));
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeTodo({required Param param}) async {
    try {
      return Right(await _todoRemoteDataSource.removeTodo(param: param));
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
