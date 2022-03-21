import 'package:demo_hive_flutter/theme.dart';
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final String icon;
  final Color iconColor;
  final Color bgColor;
  const CustomButtom({ Key? key, 
    required this.icon,
    required this.bgColor, required this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle
      ),
      child: Image.asset(
        icon,
        color: iconColor,
      )
    );
  }
}

class AppIcon extends StatelessWidget {
  final String iconPath;
  final Color iconColor;
  final bool hasText;

  const AppIcon({ Key? key, 
    required this.iconPath, 
    this.iconColor = Colors.black, required this.hasText }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasText ? Stack(
      children: [
        Image.asset(
          iconPath
        ),
        Positioned(
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6.0)
            ),
            constraints: const BoxConstraints(
              minWidth: 12,
              minHeight: 12
            ),
            child: const Text(
              '12',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
          )
        )
      ],
    ) : Image.asset(
      iconPath
    );
  }
}

class ButtonAction extends StatelessWidget {
  final IconData? iconData;
  final String title;
  final Color bgColor;
  final Function? call;
  const ButtonAction({ Key? key, 
    this.iconData, 
    required this.title, 
    required this.bgColor, 
    this.call }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => call != null ? call!() : null, 
        icon: Icon(
          iconData,
          color: bgColor != Colors.black ? Colors.black : Colors.white,
        ),
        label: Text(
          title,
          style: paragraphStyle().copyWith(
            color: bgColor != Colors.black ? Colors.black : Colors.white,
            fontWeight: FontWeight.w600
          ),
        ),
        style: ElevatedButton.styleFrom(
          onSurface: bgColor,
          primary: bgColor,
          onPrimary: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          
        ),

      ),
    );
  }
}