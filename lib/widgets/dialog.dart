import 'package:flutter/material.dart';

class TaskTypeDialog extends StatelessWidget {
  const TaskTypeDialog({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }

  
  _showDialog(BuildContext context, Widget widget) => showDialog(
    context: context, 
    builder: (context) => widget
  );
}