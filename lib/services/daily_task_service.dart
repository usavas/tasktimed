import 'dart:convert';

import 'package:todotimer/models/task_daily.dart';
import 'package:todotimer/services/task_service.dart';

import 'db_service.dart';

class DailyTaskService {
  static DailyTaskService? _instance;
  static late String _todaysTasksKey;

  DailyTaskService._internal();
  static DailyTaskService? getInstance() {
    if (_instance == null) {
      _instance = DailyTaskService._internal();
      _todaysTasksKey = DateTime.now().year.toString() +
          DateTime.now().month.toString() +
          DateTime.now().day.toString();
    }
    return _instance;
  }

  List<TaskDaily> convertToTasksList(String tasksStr) {
    var tasksMap = jsonDecode(tasksStr) as List;
    List<TaskDaily> tasks = tasksMap.map((t) => TaskDaily.fromJson(t)).toList();

    return tasks;
  }

  String convertToJson(List<TaskDaily> tasks) {
    List<Map<String, dynamic>> maps = tasks.map((t) => t.toJson()).toList();
    return jsonEncode(maps);
  }

  Future<List<TaskDaily>> initDailyTasks() async {
    var tasks = await TaskService.getInstance()?.getTasks();
    if (tasks != null) {
      var dailyTasksInit =
          tasks.map((t) => TaskDaily(task: t, elapsedSeconds: 0)).toList();
      await saveTasksDaily(dailyTasksInit);
      return dailyTasksInit;
    } else {
      return [];
    }
  }

  Future<List<TaskDaily>> getTasksDaily() async {
    DbService? _db = DbService.getInstance();

    List<TaskDaily> dailyTasks = [];
    String tasksStr = await _db?.getJson(_todaysTasksKey) ?? "[]";
    dailyTasks = convertToTasksList(tasksStr);

    if (dailyTasks.length > 0) {
      return dailyTasks;
    } else {
      // init daily tasks if not yet initialized
      var dailyTasksInit = await initDailyTasks();
      return dailyTasksInit;
    }
  }

  Future<bool?> saveTasksDaily(List<TaskDaily> tasksDaily) async {
    DbService? _db = DbService.getInstance();
    return _db?.saveAsJson(_todaysTasksKey, convertToJson(tasksDaily));
  }

  Future<bool> add(TaskDaily taskDaily) async {
    var tasks = await getTasksDaily();
    tasks.add(taskDaily);
    var res = await saveTasksDaily(tasks);
    return res ?? false;
  }

  Future<bool> update(TaskDaily taskDaily) async {
    var tasksDaily = await getTasksDaily();

    var taskToUpdate =
        tasksDaily.firstWhere((t) => t.task?.uid == taskDaily.task?.uid);
    var i = tasksDaily.indexOf(taskToUpdate);
    tasksDaily[i] = taskDaily;

    var res = await saveTasksDaily(tasksDaily);
    return res ?? false;
  }

  delete(TaskDaily taskDaily) async {
    var tasksDaily = await getTasksDaily();
    tasksDaily.removeWhere((t) => t.task?.uid == taskDaily.task?.uid);

    var res = await saveTasksDaily(tasksDaily);
    return res ?? false;
  }
}

class Task {}
