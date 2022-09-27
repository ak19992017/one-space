// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:one_space/modules/task-master/components/message.dart';
import 'package:one_space/modules/task-master/components/onelisttile.dart';

class HistorySection extends StatefulWidget {
  const HistorySection({Key? key}) : super(key: key);

  @override
  State<HistorySection> createState() => _HistorySectionState();
}

class _HistorySectionState extends State<HistorySection> {
  @override
  Widget build(BuildContext context) {
    String uniqueId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            "History",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              // color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 15),
        StreamBuilder<QuerySnapshot>(
          stream: users
              .doc(uniqueId)
              .collection('tasks')
              .orderBy('createdOn', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((document) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 5),
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
              return const Center(child: CircularProgressIndicator.adaptive());
            }
          },
        )
      ],
    );
  }
}
