import 'package:demo_hive_flutter/boxes.dart';
import 'package:demo_hive_flutter/theme.dart';
import 'package:demo_hive_flutter/widgets/custom_appbar.dart';
import 'package:demo_hive_flutter/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/task.dart';
import '../todo/todo.dart';
import '../todo_list.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: CustomAppbar(
          leadingIcon: 'assets/images/ic_menu.png',
          rightIcon: 'assets/images/ic_bell.png',
          title: 'Task Manager',
          leftCallback: () => Navigator.pushNamed(context, TodoListScreen.routeName), 
          hasRightIcon: true,
        ), 
        preferredSize: const Size.fromHeight(80)
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              children: [
                const BuildTitle(),
                ValueListenableBuilder(
                  valueListenable: Hive.box<Task>(HiveBoxes.task).listenable(), 
                  builder: (context, Box<Task> taskBox, _) {
                    if(taskBox.values.isEmpty) {
                      return const Center(
                        child: Text('Todo listing is empty'),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: taskBox.values.length,
                        itemBuilder: (context, index) {
                          Task? task = taskBox.getAt(index);
                          return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              taskBox.deleteAt(index);
                            },
                            child: TaskTile(task: task!));
                        }
                      ),
                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: const BuildActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class BuildTitle extends StatelessWidget {
  const BuildTitle({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, bottom: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome Back!', style: titleStyle()),
              const SizedBox(height: 5.0),
              Text("Here's Update Today", style: headerStyle())
            ],
          ),
          const CustomButtom(
            icon: 'assets/images/ic_search.png', 
            bgColor: Colors.black, 
            iconColor: Colors.white,
          )
        ],
      ),
    );
  }
}

class BuildActionButton extends StatelessWidget {
  const BuildActionButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      extendedPadding: const EdgeInsetsDirectional.all(20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
      icon: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0)
        ),
        child: const Icon(
          Icons.add,
          color: Colors.black,
        )
      ),
      onPressed: () => Navigator.pushNamed(context, NewTaskScreen.routeName), 
      label: Text(
        'Add Task',
        style: titleStyle().copyWith(
          fontSize: 19
        ),
      )
    );
  }
}