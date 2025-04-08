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
    ref.read(socketMethodsProvider).errorListnere(context);
    super.initState();
  }

  void createRoom(String nickname) {
    ref.watch(socketMethodsProvider).createRoom(nickname);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/imgaes/chessBackground8.png', // Replace with your image asset path
            fit: BoxFit.cover,
          ),

          // Centered Content
          Center(
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
                      const SizedBox(
                        height: 30,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " Create Room ",
                            style: TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              shadows: [
                                Shadow(color: Colors.blue, blurRadius: 15),
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
        ],
      ),
    );
  }
}
