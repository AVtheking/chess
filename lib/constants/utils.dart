import 'package:flutter/material.dart';

<<<<<<< HEAD
String uri = 'http://192.168.138.188:3000';
=======
String uri = 'http://192.168.87.188:3000';
>>>>>>> 7efa588 (ui improved)
void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
