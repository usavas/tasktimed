import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todotimer/task.dart';
import 'package:todotimer/task_item.dart';
import 'package:todotimer/task_service.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final json =
        "[{\"uid\":\"919c7bdb-01b9-4aa2-afdf-1cead1310f57\",\"title\":\"Task Title\",\"minSeconds\":120,\"maxSeconds\":200,\"elapsedSeconds\":null}]";
    List<Task> tasks =
        (jsonDecode(json) as List).map((l) => Task.fromJson(l)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body:
          //
          // Container(
          //     child: ListView.builder(
          //         itemCount: tasks.length,
          //         itemBuilder: (_, i) => TaskItem(tasks[i]))),

          Container(
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
