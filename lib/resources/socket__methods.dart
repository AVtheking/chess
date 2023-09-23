import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
<<<<<<< HEAD
=======
import 'package:multiplayer_chess/features/auth/authService.dart';
import 'package:multiplayer_chess/features/auth/authService/models/player.dart';
>>>>>>> 7efa588 (ui improved)
import 'package:multiplayer_chess/game_board.dart';
import 'package:multiplayer_chess/resources/socket_client.dart';

final socketMethodsProvider = Provider((ref) => SocketMethods(ref: ref));
final roomProvider = StateProvider<Map<String, dynamic>?>((ref) => null);
final movesProvider = StateProvider<String>(
    (ref) => 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1');
<<<<<<< HEAD
=======
final player1Provider = StateProvider<Player?>((ref) => null);
final player2Provider = StateProvider<Player?>((ref) => null);
>>>>>>> 7efa588 (ui improved)

class SocketMethods {
  final Ref _ref;
  SocketMethods({required Ref ref}) : _ref = ref;

  final _socketClient = SocketClient.instance.socket!;

<<<<<<< HEAD
  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit("createRoom", {
        {"nickname": nickname}
=======
  void createRoom(String roomName) {
    final user = _ref.read(userProvider)!;
    if (roomName.isNotEmpty) {
      _socketClient.emit("createRoom", {
        {"roomName": roomName, "nickname": user.name}
>>>>>>> 7efa588 (ui improved)
      });
    }
  }

<<<<<<< HEAD
  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit("joinRoom", {
        {"roomId": roomId, "nickname": nickname}
=======
  void joinRoom(String roomName) {
    final user = _ref.read(userProvider)!;
    if (roomName.isNotEmpty) {
      _socketClient.emit("joinRoom", {
        {"roomName": roomName, "nickname": user.name}
>>>>>>> 7efa588 (ui improved)
      });
    }
  }

  void moves(String fen, String roomId) {
    _socketClient.emit("move", {
      {"roomId": roomId, "fen": fen}
    });
  }

  void createRoomSuccessListenere(BuildContext context) {
<<<<<<< HEAD
=======
    // print("done");
>>>>>>> 7efa588 (ui improved)
    _socketClient.on("createRoomSuccess", (room) {
      _ref.read(roomProvider.notifier).update((state) => room);
      // print(room);
      Navigator.pushNamed(context, GameBoard.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on("joinRoomSuccess", (data) {
      _ref.read(roomProvider.notifier).update((state) => data);
      Navigator.pushNamed(context, GameBoard.routeName);
    });
  }

  void movesListener(BuildContext context) {
    _socketClient.on("movesListner", (data) {
      // print(data);
      _ref.read(movesProvider.notifier).update((state) => data);
    });
  }
<<<<<<< HEAD
=======

  void updatePlayerListener(BuildContext context) {
    print("here");
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
    print("here");
    _socketClient.on("updateRoom", (room) {
      print(room.toString());
      _ref.read(roomProvider.notifier).update((state) => room);
    });
  }
>>>>>>> 7efa588 (ui improved)
}
