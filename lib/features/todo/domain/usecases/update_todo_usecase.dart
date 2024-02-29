import 'package:dartz/dartz.dart';
import 'package:todo/core/failure/app_failure.dart';
import 'package:todo/features/todo/domain/repositories/repository.dart';
import 'package:todo/features/todo/domain/usecases/param.dart';
import 'package:todo/features/todo/domain/usecases/usecase.dart';

class UpdateTodoUseCase implements UseCase<void, Param> {
  final Repository _repository;

  UpdateTodoUseCase({required Repository repository})
      : _repository = repository;
  @override
  Future<Either<Failure, void>> call({required Param param}) async {
    return _repository.updateTodo(param: param);
  }
}

