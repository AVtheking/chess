import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiplayer_chess/resources/socket__methods.dart';
import 'package:multiplayer_chess/widget/custom_text.dart';

class WatingLobby extends ConsumerStatefulWidget {
  const WatingLobby({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WatingLobbyState();
}

class _WatingLobbyState extends ConsumerState<WatingLobby> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController(text: ref.read(roomProvider)!['_id']);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(text: "Wating for a player to join", fontSize: 19, shadows: [
          Shadow(
            color: Colors.blue,
            blurRadius: 5,
          ),
        ]),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
