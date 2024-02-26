import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/presentation/bloc/bloc/todo_bloc.dart';
import 'package:todo/features/todo/presentation/pages/home_page.dart';
import 'package:todo/locator.dart';

import 'locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init service locator
  await di.init();
  // initial Bloc Observer
  //Bloc.observer = const AppBlocObserver();
  runApp(
      BlocProvider<TodoBloc>(create: (context) => sl(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Todo Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage());
  }
}
