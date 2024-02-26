//sl = service locator
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:todo/features/todo/presentation/bloc/bloc/todo_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  log('initialize service.....');
  sl.registerFactory(TodoBloc.new);
 
  log('Done initialize.....');
}
