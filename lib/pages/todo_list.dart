import 'package:demo_hive_flutter/boxes.dart';
import 'package:demo_hive_flutter/pages/add_todo.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/todo.dart';

class TodoListScreen extends StatefulWidget {
  static const routeName = '/TodoListScreen';
  final String title;
  const TodoListScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Todo>(HiveBoxes.todo).listenable(),
        builder: (context, Box<Todo> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text('Todo listing is empty'),
            );
          }
          return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Todo? res = box.getAt(index);
                return Dismissible(
                  onDismissed: (direction) {
                    res!.delete();
                  },
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.amber,
                  ),
                  child: Card(
                    color: Colors.green.shade400,
                    child: Column(
                      children: [
                         
                      ],
                    ),
                  )
                );
              }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddTodoScreen())),
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ),
    );
  }
}
