// ignore_for_file: avoid_print, unused_local_variable

import 'package:chess/chess.dart' as ch;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';
import 'package:flutter_stateless_chessboard/types.dart' as Board;
import 'package:multiplayer_chess/features/auth/authService.dart';
import 'package:multiplayer_chess/resources/socket__methods.dart';
import 'package:multiplayer_chess/utils.dart';
import 'package:multiplayer_chess/widget/wating_lobby.dart';

class GameBoard extends ConsumerStatefulWidget {
  static String routeName = '/game';
  const GameBoard({Key? key}) : super(key: key);

  @override
  ConsumerState<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends ConsumerState<GameBoard> {
  @override
  void initState() {
    // print("this done");

    ref.read(socketMethodsProvider).initGameListener(context);
    ref.read(socketMethodsProvider).movesListener(context);
    ref.read(socketMethodsProvider).gameOverListener(context);
    // ref.read(socketMethodsProvider).updateRoomListener(context);
    // ref.read(socketMethodsProvider).updatePlayerListener(context);
    // ref.read(socketMethodsProvider).movesListener(context);
    // ref.read(socketMethodsProvider).endgameListener(context);
    ref.read(socketMethodsProvider).errorListnere(context);

    setState(() {});

    super.initState();
  }

  void moves(ShortMove move) {
    final gameId = ref.read(gameIdProvider)!;

    ref.watch(socketMethodsProvider).move(gameId, move);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String fen = ref.watch(fenProvider);
    final size = MediaQuery.of(context).size;
    final startGame = ref.watch(initGame);
    print(startGame);
    final whitePlayer = ref.watch(whitePlayerProvider);

    final blackPlayer = ref.watch(blackPlayerProvider);
    print('whitePlayer: $whitePlayer');
    print('blackPlayer: $blackPlayer');
    final gameId = ref.watch(gameIdProvider)!;

    final user = ref.watch(userProvider)!;

    if (checkmate(fen, context)) {
      final chess = ch.Chess.fromFEN(fen);
      // final winner =
      //     chess.turn == ch.Color.WHITE ? player2!.nickname : player1!.nickname;
      // ref.watch(socketMethodsProvider).checkmate(
      //       winner,
      //       roomData['roomName'],
      //     );
    }

    return Scaffold(
      body: !startGame
          ? WaitingLobby(gameId: gameId)
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
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/imgaes/chessBackground0.png'),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                whitePlayer != null && blackPlayer != null
                                    ? user.username != whitePlayer.name
                                        ? whitePlayer.name
                                        : blackPlayer.name
                                    : "Username",
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Chessboard(
                            orientation:
                                whitePlayer != null && blackPlayer != null
                                    ? user.username == whitePlayer.name
                                        ? Board.Color.WHITE
                                        : Board.Color.BLACK
                                    : Board.Color.WHITE,
                            fen: fen,
                            size: size.width > 500 ? 500 : size.width,
                            onMove: (move) {
                              moves(move);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/imgaes/chessBackground0.png'),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                whitePlayer != null && blackPlayer != null
                                    ? user.username == whitePlayer.name
                                        ? whitePlayer.name
                                        : blackPlayer.name
                                    : "UserName",
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
