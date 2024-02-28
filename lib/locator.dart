import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:todo/features/todo/data/repository/repository_impl.dart';
import 'package:todo/features/todo/domain/repositories/repository.dart';
import 'package:todo/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:todo/features/todo/presentation/bloc/bloc/todo_bloc.dart';

final sl = GetIt.instance;

void init() {
  log('initialize service.....');

  sl
    ..registerFactory<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    )
    ..registerLazySingleton<TodoRemoteDataSource>(
      () => TodoRemoteDataSourceImpl(firebaseFirestore: sl()),
    )
    ..registerLazySingleton<Repository>(
      () => RepositoryImpl(todoRemoteDataSource: sl()),
    )
    ..registerLazySingleton(
      () => AddTodoUseCase(repository: sl()),
    )
    ..registerFactory(() => TodoBloc(addTodoUseCase: sl()));

  log('Done initialize.....');
}
