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
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _titleController = new TextEditingController();
  final _maxController = new TextEditingController();
  final _minController = new TextEditingController();

  final kMaxTime = 480;
  final kMinTime = 1;

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
        child: Form(
          key: _formKey,
          child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            color: Colors.green[50],
            child: Container(
              height: 320,
              padding: EdgeInsets.only(
                top: 20,
                left: 32,
                right: 32,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "Task title"),
                    controller: _titleController,
                    validator: (val) {
                      int minChars = 3;
                      if (val?.trim().isEmpty ?? true) {
                        return "Please enter a title";
                      } else if ((val?.trim().length ?? 0) < minChars) {
                        return "Enter a valid title (longer than $minChars chars";
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Max minutes"),
                    keyboardType: TextInputType.number,
                    controller: _maxController,
                    validator: (val) {
                      var res = int.tryParse(val ?? '');
                      if (val?.trim().isEmpty ?? true) {
                        return "Please enter a max number";
                      } else if (res == null) {
                        return "Please enter a valid number";
                      } else if (res < kMinTime || res > kMaxTime) {
                        return "Please enter a value between 15 and 480";
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Min minutes"),
                    keyboardType: TextInputType.number,
                    controller: _minController,
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  ElevatedButton(
                    child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(fontSize: 18),
                        )),
                    onPressed: () {
                      final FormState formState = _formKey.currentState!;
                      if (formState.validate()) {
                        var _bloc = BlocProvider.of<TasksBloc>(context);
                        _bloc.add(AddNewTask(Task(
                          uid: Uuid().v4(),
                          title: _titleController.text,
                          maxSeconds:
                              (int.tryParse(_maxController.text) ?? 0) * 60,
                          minSeconds:
                              (int.tryParse(_minController.text) ?? 0) * 60,
                        )));
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
