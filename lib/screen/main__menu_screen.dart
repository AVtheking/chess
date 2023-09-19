import 'package:flutter/material.dart';
import 'package:multiplayer_chess/responsive/responsive.dart';
import 'package:multiplayer_chess/screen/create_room.dart';
import 'package:multiplayer_chess/screen/join__room.dart';
import 'package:multiplayer_chess/widget/custom_button.dart';

class MainMenu extends StatelessWidget {
  static String routeName = '/main-menu';
  const MainMenu({Key? key}) : super(key: key);
  void navigateToCreateRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void navigateToJoinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
              onTap: () {
                navigateToCreateRoom(context);
              },
              text: "Create Room"),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              onTap: () {
                navigateToJoinRoom(context);
              },
              text: "Join Room")
        ],
      ),
    );
  }
}
