import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotimer/services/alarm_service.dart';
import 'package:todotimer/views/home_screen.dart';
import 'package:todotimer/res/themeData.dart';

import 'bloc/taskbloc/tasks_bloc.dart';

void main() async {
  runApp(MyApp());
  await AlarmService.getInstance()?.initializeNotifPlugin();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksBloc>(
      create: (context) => TasksBloc()..add(InitializeDailyTasksBasedOnTasks()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: kLightTheme,
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
