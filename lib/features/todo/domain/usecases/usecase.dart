import 'package:dartz/dartz.dart';
import 'package:todo/core/failure/app_failure.dart';

abstract class UseCase<Type, Param> {
  Future<Either<Failure, Type>> call({required Param param});
}
