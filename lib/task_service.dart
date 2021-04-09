import 'dart:async';
import 'dart:convert';

import 'package:todotimer/db_service.dart';
import 'package:todotimer/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskService {
  TaskService._internal();

  static TaskService? _instance;
  static late String _todaysTasksKey;
  static late String _tasksKey;

  static getInstance() {
    if (_instance == null) {
      _instance = TaskService._internal();
      _todaysTasksKey = DateTime.now().year.toString() +
          DateTime.now().month.toString() +
          DateTime.now().day.toString();
    }

    return _instance;
  }

  List<Task> convertToTasksList(String tasksStr) {
    Iterable tasksMap = jsonDecode(tasksStr);
    List<Task> tasks = List<Task>.from(tasksMap.map((t) => Task.fromJson(t)));

    return tasks;
  }

  String convertToJson(List<Task> tasks) {
    return jsonEncode(tasks);
  }

  FutureOr<List<Task>> getTasks() async {
    DbService? _db = DbService.getInstance();

    var tasks = <Task>[];
    var tasksStr = await _db?.getJson(_tasksKey);
    if (tasksStr != null) {
      tasks = convertToTasksList(tasksStr);
    }

    return tasks;
  }

  Future<bool?> saveTasks(List<Task> tasks) async {
    DbService? _db = DbService.getInstance();
    return _db?.saveAsJson(_tasksKey, convertToJson(tasks));
  }

  Future<bool> add(Task task) async {
    var tasks = await getTasks();
    tasks.add(task);
    var res = await saveTasks(tasks);
    return res ?? false;
  }

  Future<bool> update(Task task) async {
    var tasks = await getTasks();

    var taskToUpdate = tasks.firstWhere((t) => t.uid == task.uid);
    var i = tasks.indexOf(taskToUpdate);
    tasks[i] = task;

    var res = await saveTasks(tasks);
    return res ?? false;
  }

  delete(Task task) async {
    var tasks = await getTasks();
    tasks.removeWhere((t) => t.uid == task.uid);

    var res = await saveTasks(tasks);
    return res ?? false;
  }
}
