import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiplayer_chess/resources/socket__methods.dart';
import 'package:multiplayer_chess/responsive/responsive.dart';
import 'package:multiplayer_chess/widget/custom_button.dart';
import 'package:multiplayer_chess/widget/custom_text.dart';
import 'package:multiplayer_chess/widget/custom_text_field.dart';

class JoinRoomScreen extends ConsumerStatefulWidget {
  // final BuildContext context;
  static String routeName = '/join-room';
  const JoinRoomScreen({
    Key? key,
    // required this.context,
  }) : super(key: key);

  @override
  ConsumerState<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends ConsumerState<JoinRoomScreen> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController idController = TextEditingController();
  void joinRoom(String nickname, String roomId) {
    ref.watch(socketMethodsProvider).joinRoom(roomId);
    setState(() {});
  }

  @override
  void initState() {
    ref.read(socketMethodsProvider).joinRoomSuccessListener(context);
    ref.read(socketMethodsProvider).updatePlayerListener(context);

    super.initState();
  }

  @override
  void dispose() {
    namecontroller.dispose();
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(
              text: "Join Room",
              fontSize: 70,
              shadows: [
                Shadow(blurRadius: 40, color: Colors.blue),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Material(
              child: CustomTextField(
                  namecontroller: idController, hintText: "Enter GameId"),
            ),
            const SizedBox(
              height: 35,
            ),
            CustomButton(
                onTap: () {
                  joinRoom(namecontroller.text, idController.text);
                },
                text: "Join")
          ],
        ),
      ),
    );
  }
}
