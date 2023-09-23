import 'package:chess/chess.dart' as ch;
import 'package:flutter/material.dart';

String? makeMove(String fen, dynamic move, BuildContext context) {
  final chess = ch.Chess.fromFEN(fen);

  if (chess.move(move)) {
    return chess.fen;
  }
  bool isCheckmate = chess.in_checkmate;
  if (isCheckmate) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("checkmate"),
          );
        });
  }
  return null;
}

String? getRandomMove(String fen) {
  final chess = ch.Chess.fromFEN(fen);
  final move = chess.moves();

  if (move.isEmpty) {
    return null;
  }
  move.shuffle();
  return move.first;
}

bool checkmate(String fen, BuildContext context) {
  final chess = ch.Chess.fromFEN(fen);
  return chess.in_checkmate;
}

const bgColor = Color.fromRGBO(13, 16, 34, 1);
