// ignore_for_file: avoid_print, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_space/components/button.dart';

import '../logic/task_manager.dart';
import '../screens/update_task.dart';

class Message extends StatefulWidget {
  const Message({Key? key, required this.document}) : super(key: key);
  final QueryDocumentSnapshot document;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  bool _locked = false;
  @override
  Widget build(BuildContext context) {
    TaskManager firestoreServices = TaskManager();
    return Column(
      children: [
        const Icon(EvaIcons.arrowIosUpwardOutline,
            color: Colors.grey, size: 30),
        Text(
          widget.document['task'],
          style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
        ),
        Text(
          DateFormat.yMMMd().add_jm().format(
                DateTime.parse(
                  widget.document['createdOn'].toDate().toString(),
                ),
              ),
        ),
        const SizedBox(height: 15),
        SelectableText(
          widget.document['description'],
          style: const TextStyle(fontSize: 25),
        ),
        const SizedBox(height: 40),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            OneButton(
              text: _locked ? 'Unlock' : 'Lock',
              icon: _locked ? EvaIcons.unlockOutline : EvaIcons.lockOutline,
              onTap: () {
                setState(() {
                  _locked = !_locked;
                });
              },
              color: Color(int.parse(widget.document['color'])).withOpacity(1),
              width: 100,
            ),
            OneButton(
              text: 'Close',
              icon: EvaIcons.close,
              onTap: () => Navigator.pop(context),
              color: Color(int.parse(widget.document['color'])).withOpacity(1),
              width: 100,
            ),
            if (!_locked)
              OneButton(
                text: 'Delete',
                icon: EvaIcons.trash2Outline,
                onTap: () {
                  firestoreServices.deleteTask(widget.document.id);
                  Navigator.pop(context);
                },
                color:
                    Color(int.parse(widget.document['color'])).withOpacity(1),
                width: 100,
              ),
            if (!_locked)
              OneButton(
                text: 'Edit',
                icon: EvaIcons.edit2Outline,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UpdateTaskScreen(
                        id: widget.document.id,
                        task: widget.document['task'],
                        desc: widget.document['description'],
                        category: widget.document['category'],
                        completed: widget.document['completed'],
                      );
                    },
                  ),
                ),
                color:
                    Color(int.parse(widget.document['color'])).withOpacity(1),
                width: 100,
              ),
          ],
        )
      ],
    );
  }
}
