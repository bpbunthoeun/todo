import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/features/todo/domain/entities/todo.dart';
import 'package:todo/features/todo/domain/usecases/param.dart';

abstract class TodoRemoteDataSource {
  Future<void> addTodo({required Param param});
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;

  TodoRemoteDataSourceImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;
  @override
  Future<void> addTodo({required Param param}) async {
    try {
      final todoRef = _firebaseFirestore.collection('todo').doc('NyR1Ov7GvVd8sTvF1z5k').withConverter<Todo>(
            fromFirestore: (snapshots, _) => Todo(title: 'asdfasdf'),
            toFirestore: (todo, _) => {"title": "asdfasdf"},
          );
    } catch (e) {
      rethrow;
    }
  }
}
