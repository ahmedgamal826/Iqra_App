import 'package:flutter/material.dart';

void showSnakeBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.brown,
      content: Text(
        message,
        style: TextStyle(fontSize: 25),
        textDirection: TextDirection.rtl,
      ),
    ),
  );
}
