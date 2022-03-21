import 'package:demo_hive_flutter/pages/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../boxes.dart';
import '../models/todo.dart';

class AddTodoScreen extends StatefulWidget {
  static const routeName = '/AddTodoScreen';

  const AddTodoScreen({ Key? key }) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  validated() {
    if(_fromKey.currentState != null && _fromKey.currentState!.validate()) {
      _onFormSubmit();
      print('Form Validated');
    } else {
      print('Form Validation Failed');
      return;
    }
  }

  late String title;
  late String description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _fromKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: 'Title'
                ),
                onChanged: (value) {
                  title = value;
                },
                validator: (String? value) {
                  if(value == null || value.trim().isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: 'Description'
                ),
                onChanged: (value) {
                  description = value;
                },
                validator: (String? value) {
                  if(value == null || value.trim().isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  validated();
                }, 
                child: const Text('Add Todo')
              )
            ],
          ),
        )
      ),
    );
  }

  
  void _onFormSubmit() {
    Box<Todo> todoBox = Hive.box<Todo>(HiveBoxes.todo);
    todoBox.add(Todo(title: title, description: description));
    Navigator.pushNamed(context, TodoListScreen.routeName);
  }
}