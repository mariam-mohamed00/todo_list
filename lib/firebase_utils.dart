import 'package:app_todo_list/model/task.dart';
import 'package:app_todo_list/routing/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Routes.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (value, options) => value.toFireStore());
  }

  static Future<void> addTaskToFireStore(Task task) {
    var taskCollection = getTasksCollection(); // collection
    var docRef = taskCollection.doc(); // document
    task.id = docRef.id; // auto id
    return docRef.set(task);
  }
}
