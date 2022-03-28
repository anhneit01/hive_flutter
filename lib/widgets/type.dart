import 'package:flutter/material.dart';

class TaskType extends StatelessWidget {
  final Widget title;
  final bool isBgColor;
  const TaskType({
    Key? key, required this.title, required this.isBgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical:5.0),
      decoration: BoxDecoration(
        color: isBgColor == false ? Colors.transparent : Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: isBgColor == true ? Colors.black45 : Colors.black ,
          width: 1.0
        )
      ),
      child: Center(child: title),
    );
  }
}