import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todotimer/models/task.dart';

class AlarmService {
  static AlarmService? _instance;
  AlarmService._internal();

  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  static AlarmService? getInstance() {
    if (_instance == null) {
      _instance = AlarmService._internal();
    }
    return _instance;
  }

  Future<bool?> initializeNotifPlugin() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    return await flutterLocalNotificationsPlugin?.initialize(
      initializationSettings,
    );
  }

  sendNotification(Task task) async {
    print('notifications called');
    NotificationDetails? notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
      "channelId",
      "channelName",
      "channelDescription",
      autoCancel: true,
      enableVibration: true,
      priority: Priority.max,
      visibility: NotificationVisibility.public,
      playSound: true,
    ));

    flutterLocalNotificationsPlugin?.show(
      task.uid?.hashCode ?? 1,
      task.title,
      "Congrats! Task done for the day!",
      notificationDetails,
    );
  }
}
