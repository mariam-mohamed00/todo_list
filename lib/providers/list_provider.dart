import 'package:app_todo_list/utils/firebase_utils.dart';
import 'package:app_todo_list/model/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  DateTime selectDate = DateTime.now();

  void getAllTasksFromFireStore(String uId) async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTasksCollection(uId).get();
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    /// filter data

    tasksList = tasksList.where((task) {
      if (task.dateTime?.day == selectDate.day &&
          task.dateTime?.month == selectDate.month &&
          task.dateTime?.year == selectDate.year) {
        return true;
      }
      return false;
    }).toList();

    tasksList.sort((Task task1, Task task2) {
      return task1.dateTime!.compareTo(task2.dateTime!);
    });

    notifyListeners();
  }

  void changeSelectedDate(DateTime newDate, String uId) {
    selectDate = newDate;
    getAllTasksFromFireStore(uId);
    notifyListeners();
  }
}
