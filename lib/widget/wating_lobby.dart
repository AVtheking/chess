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
          'assets/imgaes/chessBackground9.png', // Replace with your image asset path
          fit: BoxFit
              .cover, // Use BoxFit.cover to scale while maintaining aspect ratio
        ),

        // Centered Text
        const Center(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearProgressIndicator(),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Waiting for opponent to join..",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Color.fromARGB(255, 7, 134, 219),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
