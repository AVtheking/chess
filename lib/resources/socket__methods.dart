// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';
import 'package:multiplayer_chess/constants/utils.dart';
import 'package:multiplayer_chess/features/auth/authService/models/player.dart';
import 'package:multiplayer_chess/game_board.dart';
import 'package:multiplayer_chess/resources/socket_client.dart';
import 'package:multiplayer_chess/screen/main__menu_screen.dart';
import 'package:socket_io_client/socket_io_client.dart';

final socketMethodsProvider = Provider((ref) => SocketMethods(ref: ref));
final gameIdProvider = StateProvider<String?>((ref) => null);
final fenProvider = StateProvider<String>(
    (ref) => 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1');
final whitePlayerProvider = StateProvider<Player?>((ref) => null);
final blackPlayerProvider = StateProvider<Player?>((ref) => null);
final winnerProvider = StateProvider<Player?>((ref) => null);
final initGame = StateProvider<bool>((ref) => false);

class SocketMethods {
  final Ref _ref;
  SocketMethods({required Ref ref}) : _ref = ref;

  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  void createRoom(String roomName) {
    _socketClient.emit("CREATE_GAME");
  }

  void joinRoom(String gameId) {
    if (gameId.isNotEmpty) {
      _socketClient.emit("JOIN_GAME", {
        {"gameId": gameId}
      });
    }
  }

  void move(String gameId, ShortMove move) {
    print(gameId);
    print("---------------------${move.from}");
    _socketClient.emit(
        "MAKE_MOVE",
        jsonEncode({
          "data": {"gameId": gameId, "from": move.from, "to": move.to}
        }));
  }

  void checkmate(String player, String roomName) {
    _socketClient.emit("checkmate", {
      {"roomName": roomName, "player": player}
    });
  }

  void createRoomSuccessListenere(BuildContext context) {
    _socketClient.on("GAME_CREATED", (game) {
      _ref.read(gameIdProvider.notifier).update((state) => game);
      Navigator.pushReplacementNamed(context, GameBoard.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on("GAME_JOINED", (gameId) {
      _ref.read(gameIdProvider.notifier).update((state) => gameId);
      Navigator.pushReplacementNamed(context, GameBoard.routeName);
    });
  }

  void initGameListener(BuildContext context) {
    _socketClient.on("INIT_GAME", (data) {
      print(data);
      _ref.read(initGame.notifier).update((state) => true);
      var gameData = jsonDecode(data);
      print(gameData);

      print(gameData['data']['whitePlayer']);

      Player? whitePlayer = Player.fromMap(gameData['data']['whitePlayer']);
      print(whitePlayer.toJson());

      Player? blackPlayer = Player.fromMap(gameData['data']['blackPlayer']);

      var fen = gameData['data']['fen'];

      _ref
          .read(whitePlayerProvider.notifier)
          .update((state) => Player.fromJson(whitePlayer.toJson()));
      _ref
          .read(blackPlayerProvider.notifier)
          .update((state) => Player.fromJson(blackPlayer.toJson()));
      _ref.read(fenProvider.notifier).update((state) => fen);
    });
  }

  void movesListener(BuildContext context) {
    _socketClient.on("MOVE", (data) {
      print(data);
      var gameData = jsonDecode(data);

      print(gameData['data']['fen']);

      _ref
          .read(fenProvider.notifier)
          .update((state) => gameData['data']['fen']);
    });
  }

  void gameOverListener(BuildContext context) {
    _socketClient.on("GAME_OVER", (data) {
      print("Game Over");
      print(data);
      var gameData = jsonDecode(data);
      print(gameData);
      final result = gameData['data']['result'];
      if (result == "WHITE_WON") {
        final whitePlayer = _ref.read(whitePlayerProvider);
        _ref.read(winnerProvider.notifier).update((state) => whitePlayer);
      } else if (result == "BLACK_WON") {
        final blackPlayer = _ref.read(blackPlayerProvider);
        _ref.read(winnerProvider.notifier).update((state) => blackPlayer);
      } else {
        _ref.read(winnerProvider.notifier).update((state) => null);
      }
    });
    final winner = _ref.read(winnerProvider);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              "Game Ended!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green, // Customize the title color
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                winner != null
                    ? Text(
                        "${winner.name} won",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Customize the content color
                        ),
                      )
                    : const Text(
                        "Game Draw",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Customize the content color
                        ),
                      ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, MainMenu.routeName);
                      // final room = _ref.read(roomProvider);
                      // room!['isJoin'] = true;
                      // _ref
                      //     .read(roomProvider.notifier)
                      //     .update((state) => room);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // Customize the button color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
    //
  }

  // void endgameListener(BuildContext context) {
  //   _socketClient.on("endgame", (player) {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             backgroundColor: Colors.white,
  //             title: const Text(
  //               "Game Ended!",
  //               style: TextStyle(
  //                 fontSize: 24,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.green, // Customize the title color
  //               ),
  //             ),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text(
  //                   "$player won", // Replace with the actual player's name
  //                   style: const TextStyle(
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.black, // Customize the content color
  //                   ),
  //                 ),
  //                 const SizedBox(height: 20),
  //                 Align(
  //                   alignment: Alignment.bottomRight,
  //                   child: ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.pushReplacementNamed(
  //                           context, MainMenu.routeName);
  //                       final room = _ref.read(roomProvider);
  //                       room!['isJoin'] = true;
  //                       _ref
  //                           .read(roomProvider.notifier)
  //                           .update((state) => room);
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor:
  //                           Colors.blue, // Customize the button color
  //                       padding: const EdgeInsets.symmetric(
  //                           horizontal: 20, vertical: 10),
  //                     ),
  //                     child: const Text(
  //                       "OK",
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         });
  //   });
  // }

  void errorListnere(BuildContext context) {
    _socketClient.on(
      "error",
      (error) => {
        showSnackBar(context, error),
      },
    );
  }
}
