// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_space/modules/task-master/components/onelisttile.dart';

import '../components/message.dart';
import '../../../constants/constants.dart';
import '../logic/task_manager.dart';

class ReadTaskScreen extends StatefulWidget {
  const ReadTaskScreen({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  State<ReadTaskScreen> createState() => _ReadTaskScreenState();
}

class _ReadTaskScreenState extends State<ReadTaskScreen> {
  String uniqueId = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  TaskManager firestoreServices = TaskManager();
  late Stream<QuerySnapshot> futureStream;
  @override
  void initState() {
    super.initState();
    futureStream = users
        .doc(uniqueId)
        .collection('tasks')
        .where('category', isEqualTo: widget.text)
        .orderBy('createdOn', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: giveCategoryGetColor(widget.text),
        title: Text(widget.text.toUpperCase()),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: futureStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Waiting"));
          } else if (snapshot.hasError) {
            return SelectableText('${snapshot.error}');
          } else if (snapshot.hasData) {
            return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: snapshot.data!.docs.map((document) {
                return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                    child: OneListTile(
                      document: document,
                      onTap: () {
                        if (document['description'].toString().isNotEmpty) {
                          showModalBottomSheet(
                            clipBehavior: Clip.hardEdge,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return DraggableScrollableSheet(
                                initialChildSize: 0.5,
                                minChildSize: 0.2,
                                maxChildSize: 1,
                                expand: false,
                                builder: (_, controller) =>
                                    SingleChildScrollView(
                                  controller: controller,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Message(document: document),
                                  ),
                                ),
                              );
                            },
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
                          );
                        }
                      },
                    ));
              }).toList(),
            );
          } else {
            return const Text("No data");
          }
        },
      ),
    );
  }
}
