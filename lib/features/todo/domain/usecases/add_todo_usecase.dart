import 'package:dartz/dartz.dart';
import 'package:todo/core/failure/app_failure.dart';
import 'package:todo/features/todo/domain/repositories/repository.dart';
import 'package:todo/features/todo/domain/usecases/param.dart';
import 'package:todo/features/todo/domain/usecases/usecase.dart';

class AddTodoUseCase implements UseCase<void, Param> {
  final Repository _repository;

  AddTodoUseCase({required Repository repository}) : _repository = repository;
  @override
  Future<Either<Failure, void>> call({required Param param}) async {
    return _repository.addTodo(param: param);
  }
}
