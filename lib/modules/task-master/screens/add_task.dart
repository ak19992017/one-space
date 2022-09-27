// ignore_for_file: avoid_print, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../logic/task_manager.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _task = TextEditingController();
  final TextEditingController _description = TextEditingController();
  TaskManager firestoreServices = TaskManager();

  String _dropdownValue = 'home';
  bool _completed = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Task'),
          backgroundColor: giveCategoryGetColor(_dropdownValue),
          elevation: 0,
          centerTitle: true,
        ),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24.0),
                      const Text('Task',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter task here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                        controller: _task,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      const SizedBox(height: 30.0),
                      const Text(
                        'Description',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Enter description here',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)))),
                        controller: _description,
                        maxLines: 6,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  ),
                  DropdownButton<String>(
                    value: _dropdownValue,
                    items: folderList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    onChanged: (String? newValue) =>
                        setState(() => _dropdownValue = newValue!),
                  ),
                  Switch(
                    value: _completed,
                    onChanged: (value) => setState(() => _completed = value),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              giveCategoryGetColor(_dropdownValue)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 8))),
                      onPressed: () {
                        firestoreServices.addTask(_task.text, _description.text,
                            _completed, _dropdownValue);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'ADD TASK',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
