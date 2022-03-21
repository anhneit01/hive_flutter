import 'package:flutter/material.dart';

ThemeData theme() => ThemeData(
  backgroundColor: Colors.white,
  inputDecorationTheme: inputDecorationTheme()
);

UnderlineInputBorder _buildBorder(Color color) => UnderlineInputBorder(
  borderSide: BorderSide(
    color: color,
    width: 1.0
  )
);
InputDecorationTheme inputDecorationTheme() => InputDecorationTheme(
  errorBorder: _buildBorder(Colors.red),
  focusedBorder: _buildBorder(Colors.amber.shade600),
  border: _buildBorder(Colors.amberAccent),
  hintStyle: paragraphStyle().copyWith(
    fontWeight: FontWeight.w500,
    color: Colors.black
  ),
);

TextStyle headerStyle() => const TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold
);

TextStyle titleStyle() => const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w400
);
TextStyle paragraphStyle() => const TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w400
);