import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiplayer_chess/resources/socket__methods.dart';
import 'package:multiplayer_chess/widget/custom_button.dart';
import 'package:multiplayer_chess/widget/custom_text_field.dart';

class CreateRoomScreen extends ConsumerStatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends ConsumerState<CreateRoomScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    ref.read(socketMethodsProvider).createRoomSuccessListenere(context);

    super.initState();
  }

  void createRoom(String nickname) {
    ref.watch(socketMethodsProvider).createRoom(nickname);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Center(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: size.height * 0.8, maxWidth: 500),
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
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        'assets/imgaes/chessBackground6.png',
                        fit: size.width > 500 ? BoxFit.contain : BoxFit.contain,
                        width: double.infinity,
                        height: size.width > 500
                            ? size.height * 0.5
                            : size.height * 0.4,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        " Create Room ",
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
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Material(
                      child: CustomTextField(
                          namecontroller: _controller,
                          hintText: "Enter Room name"),
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                        onTap: () {
                          createRoom(_controller.text);
                        },
                        text: "Create"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
