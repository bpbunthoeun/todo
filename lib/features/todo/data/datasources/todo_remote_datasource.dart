import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/features/todo/domain/usecases/param.dart';

abstract class TodoRemoteDataSource {
  Future<void> addTodo({required Param param});
  Future<void> removeTodo({required Param param});
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;

  TodoRemoteDataSourceImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;
  @override
  Future<void> addTodo({required Param param}) async {
    try {
      await _firebaseFirestore.collection('todo').doc(param.todo!.title).set(
          {'title': param.todo!.title, 'completed': param.todo!.completed});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeTodo({required Param param}) async {
    try {
      await _firebaseFirestore
          .collection('todo')
          .doc(param.todo!.title)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
