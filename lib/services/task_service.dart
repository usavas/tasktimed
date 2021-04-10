import 'dart:async';
import 'dart:convert';

import 'package:todotimer/models/task.dart';

import 'db_service.dart';

class TaskService {
  TaskService._internal();

  static TaskService? _instance;
  static late String _tasksKey;

  static TaskService? getInstance() {
    if (_instance == null) {
      _instance = TaskService._internal();
      _tasksKey = "tasks";
    }

    return _instance;
  }

  Future<bool> add(Task task) async {
    var tasks = await getTasks();
    tasks.add(task);
    var res = await saveTasks(tasks);
    //
    print("task with id added: ${task.uid}");
    //
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
    //
    print("task with id is deleted: ${task.uid}");
    //
    var res = await saveTasks(tasks);
    return res ?? false;
  }

  Future<List<Task>> getTasks() async {
    DbService? _db = DbService.getInstance();

    List<Task> tasks = [];
    String tasksStr = await _db?.getJson(_tasksKey) ?? "[]";
    tasks = convertToTasksList(tasksStr);

    return tasks;
  }

  Future<bool?> saveTasks(List<Task> tasks) async {
    DbService? _db = DbService.getInstance();
    return _db?.saveAsJson(_tasksKey, convertToJson(tasks));
  }

  List<Task> convertToTasksList(String tasksStr) {
    var tasksMap = jsonDecode(tasksStr) as List;
    List<Task> tasks = tasksMap.map((t) => Task.fromJson(t)).toList();

    return tasks;
  }

  String convertToJson(List<Task> tasks) {
    List<Map<String, dynamic>> maps = tasks.map((t) => t.toJson()).toList();
    return jsonEncode(maps);
  }
}
