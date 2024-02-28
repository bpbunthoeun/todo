import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/features/todo/domain/usecases/param.dart';
import 'package:uuid/uuid.dart';

abstract class TodoRemoteDataSource {
  Future<void> addTodo({required Param param});
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;

  TodoRemoteDataSourceImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;
  @override
  Future<void> addTodo({required Param param}) async {
    var uuid = Uuid().v4();
    try {
      await _firebaseFirestore
          .collection('todo')
          .doc(uuid)
          .set({'id': uuid, 'title': 'testing', 'completed': false});
    } catch (e) {
      rethrow;
    }
  }
}
