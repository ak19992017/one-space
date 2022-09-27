// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../constants/constants.dart';

class TaskManager {
  String uniqueId = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // create task
  void addTask(String task, String des, bool com, String cat) {
    users
        .doc(uniqueId)
        .collection('tasks')
        .add({
          'task': task,
          'description': des,
          'completed': com,
          'category': cat,
          'color': giveCategoryGetColor(cat).value.toString(),
          'createdOn': FieldValue.serverTimestamp(),
        })
        .then((value) => print("$value\n 🎯$task🎯 added to Firebase"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  // read task
  // update task
  void updateTask(String task, String des, bool com, String cat, String id) {
    users
        .doc(uniqueId)
        .collection('tasks')
        .doc(id)
        .update({
          'task': task,
          'description': des,
          'completed': com,
          'category': cat,
          'color': giveCategoryGetColor(cat).value.toString(),
        })
        .then((value) => print("🔴User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  // delete task
  void deleteTask(String id) {
    users
        .doc(uniqueId)
        .collection('tasks')
        .doc(id)
        .delete()
        .then((value) => print("⚡Task Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  // toggle completed task
  void toggleCompleted(DocumentSnapshot doc) {
    users
        .doc(uniqueId)
        .collection('tasks')
        .doc(doc.id)
        .update({'completed': !doc['completed']})
        .then((value) => print("🍄Toggle task state"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
