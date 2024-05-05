import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiplayer_chess/resources/socket__methods.dart';

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
  void joinRoom(String gameId) {
    print(gameId);
    ref.watch(socketMethodsProvider).joinRoom(gameId);
    setState(() {});
  }

  @override
  void initState() {
    ref.read(socketMethodsProvider).joinRoomSuccessListener(context);
    // ref.read(socketMethodsProvider).updatePlayerListener(context);
    ref.read(socketMethodsProvider).errorListnere(context);

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
    return Scaffold(
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
                            " Join Room ",
                            style: TextStyle(
                              fontSize: 55,
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
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.yellow,
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ]),
                        child: TextField(
                          style: const TextStyle(color: Colors.black),
                          controller: idController,
                          decoration: const InputDecoration(
                            fillColor: Color.fromARGB(255, 194, 197, 175),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Enter Room Name",
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        // Change the color property to the shade of green you want
                        decoration: const BoxDecoration(
                            color: Colors.lightGreen,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 205, 214,
                                    213), // Change the shadow color if needed
                                blurRadius: 10,
                                spreadRadius: 0,
                              )
                            ]),
                        child: ElevatedButton(
                          onPressed: () {
                            joinRoom(idController.text);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 182, 218, 37),
                              minimumSize: const Size(double.infinity, 55)),
                          child: const Text(
                            "Join Room",
                            style: TextStyle(fontSize: 18, shadows: [
                              Shadow(
                                  color: Color.fromARGB(255, 228, 190, 133),
                                  blurRadius: 5)
                            ]),
                          ),
                        ),
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
