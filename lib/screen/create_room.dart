import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiplayer_chess/resources/socket__methods.dart';
import 'package:multiplayer_chess/responsive/responsive.dart';
import 'package:multiplayer_chess/widget/custom_button.dart';
import 'package:multiplayer_chess/widget/custom_text.dart';

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
    // print('this part done');
    ref.read(socketMethodsProvider).createRoomSuccessListenere(context);
    super.initState();
  }

  void createRoom(String nickname) {
    // print("this part also done");
    ref.watch(socketMethodsProvider).createRoom(nickname);
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
              text: "Create Room",
              fontSize: 70,
              shadows: [
                Shadow(
                  color: Colors.green,
                  blurRadius: 40,
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            CustomButton(
                onTap: () {
                  createRoom(_controller.text);
                },
                text: "Create")
          ],
        ),
      ),
    );
  }
}
