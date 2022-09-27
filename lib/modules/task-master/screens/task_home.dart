import 'package:flutter/material.dart';
import 'package:one_space/modules/task-master/screens/add_task.dart';

import '../components/folder.dart';
import '../components/history.dart';
import '../components/onecalender.dart';

class TaskHomeScreen extends StatefulWidget {
  const TaskHomeScreen({Key? key}) : super(key: key);

  @override
  State<TaskHomeScreen> createState() => _TaskHomeScreenState();
}

class _TaskHomeScreenState extends State<TaskHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Task master'), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTaskScreen(),
            ),
          );
        },
        label: const Text("Add task",
            style: TextStyle(fontSize: 20, color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20, width: double.infinity),
            // HeaderSection(),
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blueGrey[800],
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: const OneCalender(),
            ),
            const FoldersSection(),
            const HistorySection(),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
