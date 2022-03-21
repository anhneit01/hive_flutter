
import 'package:demo_hive_flutter/pages/add_todo.dart';
import 'package:demo_hive_flutter/pages/home/home_screen.dart';
import 'package:demo_hive_flutter/pages/todo/edit_task.dart';
import 'package:demo_hive_flutter/pages/todo/new_task.dart';
import 'package:demo_hive_flutter/pages/todo_list.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  TodoListScreen.routeName: (context) => const TodoListScreen(title: 'Hello'),
  AddTodoScreen.routeName: (context) => const AddTodoScreen(),
  TaskEditScreen.routeName: (context) => const TaskEditScreen(),
  NewTaskScreen.routeName: (context) => const NewTaskScreen(),
};