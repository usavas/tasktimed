import 'package:flutter/material.dart';
import 'package:todotimer/models/task.dart';
import 'package:todotimer/services/task_service.dart';
import 'package:todotimer/views/task_item.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: Container(
          child: FutureBuilder(
              future: TaskService.getInstance()?.getTasks(),
              builder: (context, snapShot) {
                if (snapShot.hasError) {
                  return Center(child: Text(snapShot.error.toString()));
                }
                if (snapShot.hasData) {
                  var tasks = snapShot.data as List<Task>;
                  if (tasks.length > 0) {
                    return ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (_, i) => TaskItem((tasks[i])));
                  } else {
                    return Center(child: Text('no task in the list'));
                  }
                } else {
                  return Center(child: Text('retrieving tasks'));
                }
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            TaskService.getInstance()?.add(Task(
                uid: Uuid().v4(),
                title: 'Task Title',
                minSeconds: 120,
                maxSeconds: 200));
          });
        },
        tooltip: 'Add new task',
        child: Icon(Icons.add),
      ),
    );
  }
}
