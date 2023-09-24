import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController namecontroller;
  final String hintText;
  final bool isObscureText;

  const CustomTextField(
      {Key? key, // Use 'key' instead of 'super.key'
      required this.namecontroller,
      required this.hintText,
      this.isObscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.yellow,
          blurRadius: 5,
          spreadRadius: 2,
        ),
      ]),
      child: TextField(
        style: const TextStyle(color: Colors.black),
        obscureText: isObscureText,
        controller: namecontroller,
        decoration: InputDecoration(
          fillColor: const Color.fromARGB(
              255, 194, 197, 175), // Ensure 'bgColor' is defined correctly
          filled: true,

          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
