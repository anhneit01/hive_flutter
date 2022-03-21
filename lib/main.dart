import 'package:demo_hive_flutter/boxes.dart';
import 'package:demo_hive_flutter/models/task.dart';
import 'package:demo_hive_flutter/pages/todo/todo.dart';
import 'package:demo_hive_flutter/routes.dart';
import 'package:demo_hive_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async{
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>(HiveBoxes.task);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NewTaskScreen(),
      routes: routes,
      theme: theme(),
    );
  }
}