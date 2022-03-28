import 'package:demo_hive_flutter/pages/home/home_screen.dart';
import 'package:demo_hive_flutter/pages/todo/edit_task.dart';
import 'package:demo_hive_flutter/pages/todo/new_task.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  TaskEditScreen.routeName: (context) => const TaskEditScreen(),
  NewTaskScreen.routeName: (context) => const NewTaskScreen(),
};