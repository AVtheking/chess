import 'dart:io'; // Import the dart:io library

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart';
import 'package:multiplayer_chess/resources/socket__methods.dart';
import 'package:multiplayer_chess/responsive/responsive.dart';
import 'package:multiplayer_chess/utils.dart';

class GameBoard extends ConsumerStatefulWidget {
  static String routeName = '/game';
  const GameBoard({Key? key}) : super(key: key);

  @override
  ConsumerState<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends ConsumerState<GameBoard> {
  @override
  void initState() {
    ref.read(socketMethodsProvider).movesListener(context);
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
    );
  }
}
