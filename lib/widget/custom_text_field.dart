import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController namecontroller;
  final String hintText;
  final bool isReadOnly;

  const CustomTextField(
      {Key? key, // Use 'key' instead of 'super.key'
      required this.namecontroller,
      required this.hintText,
      this.isReadOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.blue,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ]),
        child: TextField(
            readOnly: isReadOnly,
            controller: namecontroller,
            decoration: InputDecoration(
              fillColor: const Color.fromRGBO(
                  13, 16, 34, 1), // Ensure 'bgColor' is defined correctly
              filled: true,
              hintText: hintText,
            )));
  }
}
