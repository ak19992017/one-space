import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../logic/task_manager.dart';

class OneListTile extends StatefulWidget {
  const OneListTile({super.key, required this.document, required this.onTap});
  final QueryDocumentSnapshot document;
  final Function() onTap;

  @override
  State<OneListTile> createState() => _OneListTileState();
}

class _OneListTileState extends State<OneListTile> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    TaskManager firestoreServices = TaskManager();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        title: Text(
          widget.document['task'],
          style: TextStyle(
            fontSize: 25,
            decoration: widget.document['completed']
                ? TextDecoration.lineThrough
                : null,
            decorationThickness: 3,
          ),
        ),
        leading: (IconButton(
          icon: widget.document['completed']
              ? const Icon(Icons.check_box_outlined)
              : const Icon(Icons.check_box_outline_blank),
          onPressed: () {
            firestoreServices.toggleCompleted(widget.document);
          },
        )),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: widget.document['description'].toString().isNotEmpty
            ? Color(int.parse(widget.document['color'])).withOpacity(1)
            : null,
        trailing: IconButton(
          icon: isFavourite
              ? const Icon(EvaIcons.star, color: Colors.yellow)
              : const Icon(EvaIcons.starOutline),
          onPressed: () {
            setState(() {
              isFavourite = !isFavourite;
            });
          },
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        onTap: widget.onTap,
      ),
    );
  }
}
