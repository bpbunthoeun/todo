import 'package:todo/core/failure/app_failure.dart';

abstract class AppException implements Exception {
  final String code;
  final String message;

  AppException({required this.code, required this.message});

  Failure toFailure();
}

class DuplicatedException extends AppException {
  DuplicatedException({super.code = '000', super.message = 'duplicate'});

  @override
  Failure toFailure() => DuplicatedFailure(code: code, message: message);
}

class EmptyException extends AppException {
  EmptyException({super.code = '001', super.message = 'empty'});

  @override
  Failure toFailure() => EmptyFailure(code: code, message: message);
}


//  Error.duplicate => const Text('The item is already exited!'),
//  Error.empty => const Text('The list can not be empty!')