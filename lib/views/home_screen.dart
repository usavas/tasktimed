import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotimer/bloc/dailytask_bloc/dailytask_bloc.dart';
import 'package:todotimer/models/task.dart';
import 'package:todotimer/models/task_daily.dart';
import 'package:todotimer/services/daily_task_service.dart';
import 'package:todotimer/services/task_service.dart';
import 'package:todotimer/views/daily_task_item.dart';
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
        title: Text('Daily Tasks'),
      ),
      body: Container(
          child: FutureBuilder(
              future: DailyTaskService.getInstance()?.getTasksDaily(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  var tasks = snapshot.data as List<TaskDaily>;
                  if (tasks.length > 0) {
                    return ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (_, i) => BlocProvider<DailyTaskBloc>(
                            create: (ctx) => DailyTaskBloc()
                              ..add(InitDailyTaskValue(tasks[i])),
                            child: DailyTaskItem()));
                  } else {
                    return Center(child: Text('no task in the list'));
                  }
                } else {
                  return Center(child: Text('retrieving the task list'));
                }
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        tooltip: 'Add new task',
        child: Icon(Icons.add),
      ),
    );
  }
}
