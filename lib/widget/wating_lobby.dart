import 'package:flutter/material.dart';

class WaitingLobby extends StatelessWidget {
  const WaitingLobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        Image.asset(
          'assets/imgaes/chessBackground8.png', // Replace with your image asset path
          fit: BoxFit
              .fill, // Use BoxFit.cover to scale while maintaining aspect ratio
        ),

        // Centered Text
        const Center(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Waiting for opponent to join!!",
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.blue,
                    blurRadius: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
