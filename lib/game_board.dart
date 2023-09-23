import 'package:chess/chess.dart' as ch;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';
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
    print("this done");

    ref.read(socketMethodsProvider).updateRoomListener(context);
    ref.read(socketMethodsProvider).updatePlayerListener(context);
    ref.read(socketMethodsProvider).movesListener(context);
    ref.read(socketMethodsProvider).endgameListener(context);

    setState(() {});

    super.initState();
  }

  void moves(String fen) {
    final room = ref.read(roomProvider)!;
    ref.watch(socketMethodsProvider).moves(fen, room['roomName']);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String _fen = ref.watch(movesProvider);
    final size = MediaQuery.of(context).size;
    final player1 = ref.watch(player1Provider);
    // print(player1);
    final player2 = ref.watch(player2Provider);
    final roomData = ref.watch(roomProvider)!;
    // print(roomData);
    final user = ref.watch(userProvider)!;
    if (checkmate(_fen, context)) {
      final chess = ch.Chess.fromFEN(_fen);
      final winner =
          chess.turn == ch.Color.WHITE ? player1!.nickname : player2!.nickname;
      ref.watch(socketMethodsProvider).checkmate(
            winner,
            roomData['roomName'],
          );
    }

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
                                  : player2.nickname
                              : "Username"),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: AbsorbPointer(
                            absorbing: roomData['turn']['socketId'] !=
                                ref
                                    .watch(socketMethodsProvider)
                                    .socketClient
                                    .id,
                            child: Chessboard(
                              orientation: player1 != null && player2 != null
                                  ? user.name == player1.nickname
                                      ? player1.playertype == 'w'
                                          ? Color.WHITE
                                          : Color.BLACK
                                      : player2!.playertype == 'w'
                                          ? Color.WHITE
                                          : Color.BLACK
                                  : Color.WHITE,
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
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(player1 != null && player2 != null
                              ? user.name != player1.nickname
                                  ? player1.nickname
                                  : player2.nickname
                              : "UserName"),
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
