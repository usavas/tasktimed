import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotimer/bloc/taskbloc/tasks_bloc.dart';
import 'package:todotimer/models/task.dart';
import 'package:uuid/uuid.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen();

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  var _titleController = new TextEditingController();
  var _maxController = new TextEditingController();
  var _minController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          top: 20,
          left: 32,
          right: 32,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Enter task title"),
              controller: _titleController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Enter max minutes"),
              keyboardType: TextInputType.number,
              controller: _maxController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Enter min minutes"),
              keyboardType: TextInputType.number,
              controller: _minController,
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            ElevatedButton(
              child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(fontSize: 18),
                  )),
              onPressed: () {
                var _bloc = BlocProvider.of<TasksBloc>(context);
                _bloc.add(AddNewTask(Task(
                  uid: Uuid().v4(),
                  title: _titleController.text,
                  maxSeconds: int.tryParse(_maxController.text)! * 60,
                  minSeconds: int.tryParse(_minController.text)! * 60,
                )));
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
