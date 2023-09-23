import 'package:flutter/material.dart';

String uri = 'http://192.168.87.188:3000';
void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
