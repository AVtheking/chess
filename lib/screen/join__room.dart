import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiplayer_chess/resources/socket__methods.dart';
import 'package:multiplayer_chess/responsive/responsive.dart';
import 'package:multiplayer_chess/widget/custom_button.dart';
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
    final size = MediaQuery.of(context).size;
    return Responsive(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(boxShadow: [
                  // BoxShadow(
                  //   color: Color.fromARGB(255, 5, 75, 8),
                  //   blurRadius: 0,
                  //   spreadRadius: 0,
                  // )
                ]),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    'assets/imgaes/chessBackground7.png',
                    fit: size.width > 500 ? BoxFit.cover : BoxFit.contain,
                    width: double.infinity,
                    height: size.width > 500
                        ? size.height * 0.4
                        : size.height * 0.3,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " Join Room ",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      shadows: [
                        Shadow(color: Colors.green, blurRadius: 10),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Material(
                  child: CustomTextField(
                      namecontroller: idController, hintText: "Enter RoomName"),
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                    onTap: () {
                      joinRoom(namecontroller.text, idController.text);
                    },
                    text: "Join"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
