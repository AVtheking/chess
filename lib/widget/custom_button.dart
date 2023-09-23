import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Change the color property to the shade of green you want
      decoration: const BoxDecoration(color: Colors.lightGreen, boxShadow: [
        BoxShadow(
          color: Colors.lightGreen, // Change the shadow color if needed
          blurRadius: 10,
          spreadRadius: 0,
        )
      ]),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 7, 126, 11),
            minimumSize: const Size(double.infinity, 50)),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
