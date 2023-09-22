import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiplayer_chess/game_board.dart';
import 'package:multiplayer_chess/resources/socket_client.dart';

final socketMethodsProvider = Provider((ref) => SocketMethods(ref: ref));
final roomProvider = StateProvider<Map<String, dynamic>?>((ref) => null);
final movesProvider = StateProvider<String>(
    (ref) => 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1');

class SocketMethods {
  final Ref _ref;
  SocketMethods({required Ref ref}) : _ref = ref;

  final _socketClient = SocketClient.instance.socket!;

  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit("createRoom", {
        {"nickname": nickname}
      });
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit("joinRoom", {
        {"roomId": roomId, "nickname": nickname}
      });
    }
  }

  void moves(String fen, String roomId) {
    _socketClient.emit("move", {
      {"roomId": roomId, "fen": fen}
    });
  }

  void createRoomSuccessListenere(BuildContext context) {
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
}
