import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiplayer_chess/constants/utils.dart';

class WaitingLobby extends StatelessWidget {
  final String gameId;
  const WaitingLobby({Key? key, required this.gameId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        Image.asset(
          'assets/imgaes/chessBackground9.png',
          fit: BoxFit.cover,
        ),

        // Centered Text
        Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LinearProgressIndicator(),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      const Text(
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
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: gameId));
                          showSnackBar(context, "Game ID copied to clipboard");
                        },
                        child: Text(
                          "Game ID: $gameId",
                          style: const TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 187, 186, 192),
                            shadows: [
                              Shadow(
                                color: Color.fromARGB(255, 38, 71, 218),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
