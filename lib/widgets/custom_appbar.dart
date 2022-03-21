import 'package:demo_hive_flutter/widgets/button.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String? title;
  final String leadingIcon;
  final Function? leftCallback;
  final String rightIcon;
  final bool hasRightIcon;
  const CustomAppbar(
      {Key? key,
      this.title,
      required this.leadingIcon,
      this.leftCallback,
      required this.rightIcon, 
      required this.hasRightIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => leftCallback != null ? leftCallback!() : null,
          child: hasRightIcon ? CustomButtom(
            icon: leadingIcon, 
            bgColor: Colors.black, 
            iconColor: Colors.white) 
          : CustomButtom(
            icon: leadingIcon, 
            bgColor: Theme.of(context).backgroundColor, 
            iconColor: Colors.black)
        ),
        title: Text(
          title!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20
          ),
        ),
        centerTitle: true,
        actions: [
          hasRightIcon ? AppIcon(iconPath: rightIcon, hasText: true,) : Container()
        ]
      ),
    );
  }
}
