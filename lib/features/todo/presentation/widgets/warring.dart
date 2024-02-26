import 'package:flutter/material.dart';
import 'package:todo/features/todo/presentation/bloc/bloc/todo_bloc.dart';

wanning({required BuildContext context, required Failure failure}) async {
  return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(failure.error.name),
            content: switch (failure.error) {
              Error.duplicate => const Text('The item is already exited!'),
              Error.empty => const Text('The list can not be empty!')
            },
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK')),
            ],
            actionsAlignment: MainAxisAlignment.center,
          ));
}
