import 'package:demo_hive_flutter/theme.dart';
import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final Widget widget;

  const MyInputField({ Key? key, 
  required this.title, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: paragraphStyle().copyWith(
              color: Colors.grey.shade400
            ),
          ),
          SizedBox(
            height: 52,
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: widget),
              ],
            )
          ),
        ],
      ),
    );
  }
}