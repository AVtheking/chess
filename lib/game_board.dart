<<<<<<< HEAD
import 'dart:io'; // Import the dart:io library

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';
import 'package:multiplayer_chess/resources/socket__methods.dart';
import 'package:multiplayer_chess/responsive/responsive.dart';
import 'package:multiplayer_chess/utils.dart';
=======
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';
import 'package:multiplayer_chess/features/auth/authService.dart';
import 'package:multiplayer_chess/resources/socket__methods.dart';
import 'package:multiplayer_chess/utils.dart';
import 'package:multiplayer_chess/widget/wating_lobby.dart';
>>>>>>> 7efa588 (ui improved)

class GameBoard extends ConsumerStatefulWidget {
  static String routeName = '/game';
  const GameBoard({Key? key}) : super(key: key);

  @override
  ConsumerState<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends ConsumerState<GameBoard> {
  @override
  void initState() {
<<<<<<< HEAD
    ref.read(socketMethodsProvider).movesListener(context);
=======
    print("this done");
    ref.read(socketMethodsProvider).updateRoomListener(context);
    ref.read(socketMethodsProvider).movesListener(context);
    ref.read(socketMethodsProvider).updatePlayerListener(context);
    setState(() {});

>>>>>>> 7efa588 (ui improved)
    super.initState();
  }

  void moves(String fen) {
    final room = ref.read(roomProvider)!;
    ref.read(socketMethodsProvider).moves(fen, room['_id']);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String _fen = ref.watch(movesProvider);
    final size = MediaQuery.of(context).size;
<<<<<<< HEAD

    // Adjust constraints based on the platform

    return Scaffold(
      body: Responsive(
        child: Chessboard(
          fen: _fen,
          size: Platform.isWindows ? 500 : size.width,
          onMove: (move) {
            final nextFen = makeMove(_fen,
                {'from': move.from, 'to': move.to, 'promotion': 'q'}, context);
            if (nextFen != null) {
              moves(nextFen);
            }
          },
        ),
      ),
=======
    final player1 = ref.watch(player1Provider);

    final player2 = ref.watch(player2Provider);
    final roomData = ref.watch(roomProvider)!;
    final user = ref.watch(userProvider)!;

    return Scaffold(
      body: roomData['isJoin']
          ? const WatingLobby()
          : Center(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxHeight: size.height * 0.8, maxWidth: 700),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(player1 != null && player2 != null
                              ? user.name == player1.nickname
                                  ? player1.nickname
                                  : player2!.nickname
                              : "Username"),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Chessboard(
                            fen: _fen,
                            size: size.width > 500 ? 500 : size.width,
                            onMove: (move) {
                              final nextFen = makeMove(
                                _fen,
                                {
                                  'from': move.from,
                                  'to': move.to,
                                  'promotion': 'q'
                                },
                                context,
                              );
                              if (nextFen != null) {
                                moves(nextFen);
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(player1 != null && player2 != null
                              ? user.name != player1!.nickname
                                  ? player1!.nickname
                                  : player2!.nickname
                              : "UserName"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
>>>>>>> 7efa588 (ui improved)
    );
  }
}
