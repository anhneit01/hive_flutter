import 'package:demo_hive_flutter/theme.dart';
import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget {
  final String? title;
  final Widget widget;

  const MyInputField({ Key? key, 
  this.title, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return title != null ? Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleField(title: title!),
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
    ) : widget;
  }
}

class TitleField extends StatelessWidget {
  const TitleField({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: paragraphStyle().copyWith(
        color: Colors.grey.shade400
      ),
    );
  }
}