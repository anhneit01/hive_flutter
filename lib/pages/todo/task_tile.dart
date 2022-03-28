import 'package:demo_hive_flutter/pages/todo/todo.dart';
import 'package:demo_hive_flutter/theme.dart';
import 'package:flutter/material.dart';

import '../../models/task.dart';
import '../../widgets/type.dart';
import '../../widgets/widget.dart';

class TaskTile extends StatelessWidget {
  final Task? task;
  const TaskTile({ Key? key, this.task }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
            height: MediaQuery.of(context).size.height * 3/12,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.amber.shade300,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [BoxShadow(
                color: Colors.black.withOpacity(0.03),
                offset: const Offset(0, 9),
                blurRadius: 20,
                spreadRadius: 1
              )]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TaskType(
                      title: Text('School', style: paragraphStyle()), 
                      isBgColor: false
                    ),
                    const SizedBox(width: 10.0),
                    TaskType(
                      title: Text('School', style: paragraphStyle()), 
                      isBgColor: false
                    ),
                  ],
                ),
                const Spacer(),
                Text(task!.title, style: titleStyle().copyWith(
                  fontWeight: FontWeight.w600
                )),
                const Spacer(),
                Row(
                  children: [
                    const AppIcon(
                      iconPath: 'assets/images/ic_calendar.png', 
                      hasText: false
                    ),
                    const SizedBox(width: 10.0),
                    Text(task!.deadline, style: paragraphStyle())
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    const Icon(Icons.access_alarm, size: 26,),
                    const SizedBox(width: 10.0),
                    Text('${task!.startTime} - ${task!.endTime}', style: paragraphStyle())
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 5,
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, TaskEditScreen.routeName), 
              icon: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Center(
                  child: Icon(
                    Icons.edit, 
                    color: Colors.white,
                  )
                ),
              )
            )
          ),
          Positioned(
            bottom: 30,
            right: 15,
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 2
                )
              )
            )
          )
        ]
    );
  }
}


void doNothing(BuildContext context){}

void delete(BuildContext context) {
  
}