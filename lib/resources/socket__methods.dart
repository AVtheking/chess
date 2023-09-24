import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiplayer_chess/features/auth/authService.dart';
import 'package:multiplayer_chess/features/auth/authService/models/player.dart';
import 'package:multiplayer_chess/game_board.dart';
import 'package:multiplayer_chess/resources/socket_client.dart';
import 'package:multiplayer_chess/screen/main__menu_screen.dart';
import 'package:socket_io_client/socket_io_client.dart';

final socketMethodsProvider = Provider((ref) => SocketMethods(ref: ref));
final roomProvider = StateProvider<Map<String, dynamic>?>((ref) => null);
final movesProvider = StateProvider<String>(
    (ref) => 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1');
final player1Provider = StateProvider<Player?>((ref) => null);
final player2Provider = StateProvider<Player?>((ref) => null);

class SocketMethods {
  final Ref _ref;
  SocketMethods({required Ref ref}) : _ref = ref;

  final _socketClient = SocketClient.instance.socket!;
  Socket get socketClient => _socketClient;

  void createRoom(String roomName) {
    final user = _ref.read(userProvider)!;
    if (roomName.isNotEmpty) {
      _socketClient.emit("createRoom", {
        {"roomName": roomName, "nickname": user.name}
      });
    }
  }

  void joinRoom(String roomName) {
    final user = _ref.read(userProvider)!;
    if (roomName.isNotEmpty) {
      _socketClient.emit("joinRoom", {
        {"roomName": roomName, "nickname": user.name}
      });
    }
  }

  void moves(String fen, String roomId) {
    _socketClient.emit("move", {
      {"roomName": roomId, "fen": fen}
    });
  }

  void checkmate(String player, String roomName) {
    _socketClient.emit("checkmate", {
      {"roomName": roomName, "player": player}
    });
  }

  void createRoomSuccessListenere(BuildContext context) {
    // print("done");
    _socketClient.on("createRoomSuccess", (room) {
      _ref.read(roomProvider.notifier).update((state) => room);
      // print(room);
      Navigator.pushNamed(context, GameBoard.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    // print('called');
    _socketClient.on("joinRoomSuccess", (roomData) {
      _ref.read(roomProvider.notifier).update((state) => roomData);
      Navigator.pushNamed(context, GameBoard.routeName);
    });
  }

  void movesListener(BuildContext context) {
    _socketClient.on("movesListner", (data) {
      // print(data);
      _ref.read(movesProvider.notifier).update((state) => data['fen']);
      _ref.read(roomProvider.notifier).update((state) => data['room']);
    });
  }

  void updatePlayerListener(BuildContext context) {
    // print("here");
    _socketClient.on("updatePlayers", (playerData) {
      _ref
          .read(player1Provider.notifier)
          .update((state) => Player.fromMap(playerData[0]));
      _ref
          .read(player2Provider.notifier)
          .update((state) => Player.fromMap(playerData[1]));
    });
  }

  void updateRoomListener(BuildContext context) {
    // print("here");
    _socketClient.on("updateRoom", (room) {
      // print(room.toString());
      _ref.read(roomProvider.notifier).update((state) => room);
    });
  }

  void endgameListener(BuildContext context) {
    _socketClient.on("endgame", (player) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.green,
              title: const Text("Game End"),
              content: Text(
                "$player won ",
                style: const TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.pushReplacementNamed(
                          context, MainMenu.routeName);
                    },
                    child: const Text("Ok"))
              ],
            );
          });
    });
  }
}
