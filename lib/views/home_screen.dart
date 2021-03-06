import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotimer/bloc/dailytask_bloc/dailytask_bloc.dart';
import 'package:todotimer/bloc/taskbloc/tasks_bloc.dart';
import 'package:todotimer/views/daily_task_item.dart';
import 'package:todotimer/views/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (taskContext, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Daily Tasks'),
          ),
          body: Builder(builder: (context) {
            if (state is TasksChanged) {
              return Container(child: Builder(builder: (_) {
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
                  return Center(
                    child: Text(
                      'No tasks in the list!',
                    ),
                  );
                }
              }));
            } else {
              return Center(child: Text('Loading the tasks...'));
            }
          }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (taskContext) => TaskScreen()));
            },
            tooltip: 'Add new task',
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
