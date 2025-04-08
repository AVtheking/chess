import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiplayer_chess/resources/socket__methods.dart';
import 'package:multiplayer_chess/responsive/responsive.dart';
import 'package:multiplayer_chess/screen/create_room.dart';
import 'package:multiplayer_chess/screen/join__room.dart';

class MainMenu extends ConsumerWidget {
  static String routeName = '/main-menu';
  const MainMenu({Key? key}) : super(key: key);
  void navigateToCreateRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void navigateToJoinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final gameId = ref.watch(gameIdProvider);
    return Responsive(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    'assets/imgaes/chessBackground1.png',
                    fit: size.width > 500 ? BoxFit.cover : BoxFit.contain,
                    width: double.infinity,
                    height: size.width > 500
                        ? size.height * 0.4
                        : size.height * 0.3,
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
                    " Play Online ",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        shadows: [
                          Shadow(color: Colors.yellow, blurRadius: 10),
                        ],
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors
                          .lightGreen, // Change the shadow color if needed
                      blurRadius: 20,
                      spreadRadius: 0,
                    )
                  ]),
                  child: ElevatedButton(
                    onPressed: () {
                      navigateToCreateRoom(context);
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor:
                            const Color.fromARGB(255, 14, 145, 197),
                        minimumSize: const Size(double.infinity, 60)),
                    child: const Text(
                      "Create Room",
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(color: Colors.yellow, blurRadius: 2)
                          ]),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 8, 135,
                          157), // Change the shadow color if needed
                      blurRadius: 20,
                      spreadRadius: 1,
                    )
                  ]),
                  child: ElevatedButton(
                    onPressed: () {
                      navigateToJoinRoom(context);
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor:
                            const Color.fromARGB(255, 194, 197, 175),
                        minimumSize: const Size(double.infinity, 60)),
                    child: const Text(
                      "Join Room",
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(color: Colors.yellow, blurRadius: 2)
                          ]),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // if (room != null && !room['isJoin'])
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Container(
              //       decoration: const BoxDecoration(
              //         boxShadow: [
              //           BoxShadow(
              //             color: Color.fromARGB(255, 8, 135, 157),
              //             blurRadius: 5,
              //             spreadRadius: 3,
              //           )
              //         ],
              //       ),
              //       child: ElevatedButton(
              //         onPressed: () {
              //           Navigator.pushNamed(context, GameBoard.routeName);
              //         },
              //         style: ElevatedButton.styleFrom(
              //           elevation: 10,
              //           backgroundColor:
              //               const Color.fromARGB(255, 194, 197, 175),
              //           minimumSize: const Size(double.infinity, 60),
              //         ),
              //         child: const Text(
              //           "Resume Game",
              //           style: TextStyle(
              //             fontSize: 23,
              //             color: Colors.black,
              //             fontWeight: FontWeight.bold,
              //             shadows: [
              //               Shadow(color: Colors.yellow, blurRadius: 2)
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
