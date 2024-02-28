import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String code;
  final String message;

  const Failure({required this.code, required this.message});

  @override
  List<Object?> get props => [code, message];
}

class DuplicatedFailure extends Failure {
  const DuplicatedFailure({required super.code, required super.message});
}

class EmptyFailure extends Failure {
  const EmptyFailure({required super.code, required super.message});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.code = 'Unknown code', required super.message});
}
