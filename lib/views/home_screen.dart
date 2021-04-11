import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotimer/bloc/dailytask_bloc/dailytask_bloc.dart';
import 'package:todotimer/bloc/taskbloc/tasks_bloc.dart';
import 'package:todotimer/models/task.dart';
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
    return BlocProvider<TasksBloc>(
      create: (context) => TasksBloc()..add(InitializeDailyTasksBasedOnTasks()),
      child: BlocBuilder<TasksBloc, TasksState>(
        builder: (taskContext, state) {
          if (state is TasksChanged) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Daily Tasks'),
              ),
              body: Container(child: Builder(builder: (_) {
                var tasks = state.dailyTasks;
                if (tasks.length > 0) {
                  return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (_, i) => BlocProvider<DailyTaskBloc>(
                          key: GlobalKey(),
                          create: (ctx) => DailyTaskBloc()
                            ..add(InitDailyTaskValues(tasks[i])),
                          child: DailyTaskItem()));
                } else {
                  return Center(child: Text('no task in the list'));
                }
              })),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  var bloc = BlocProvider.of<TasksBloc>(taskContext);
                  bloc.add(AddNewTask(Task(
                    uid: Uuid().v4(),
                    title: "New task in the neighborhood",
                    minSeconds: 120,
                    maxSeconds: 1200,
                  )));
                },
                tooltip: 'Add new task',
                child: Icon(Icons.add),
              ),
            );
          } else {
            return Center(child: Text('retrieving the task list'));
          }
        },
      ),
    );
  }
}
