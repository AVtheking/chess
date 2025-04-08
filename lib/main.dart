import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiplayer_chess/features/auth/authService.dart';
import 'package:multiplayer_chess/features/auth/screens/auth_screen.dart';
import 'package:multiplayer_chess/features/auth/screens/email_verification.dart';
import 'package:multiplayer_chess/features/auth/screens/sign_in_screen.dart';
import 'package:multiplayer_chess/game_board.dart';
import 'package:multiplayer_chess/screen/create_room.dart';
import 'package:multiplayer_chess/screen/join__room.dart';
import 'package:multiplayer_chess/screen/main__menu_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  String initialRoute = AuthScreen.routeName;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    checkAuth();
    super.initState();
  }

  Future<void> checkAuth() async {
    await ref.read(authServiceProvider).getUserData(context);

    final user = ref.read(userProvider);

    final isAuthenticated = user != null ? true : false;

    Future.delayed(Duration.zero, () {
      if (isAuthenticated) {
        navigatorKey.currentState?.pushReplacementNamed(MainMenu.routeName);
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(31, 202, 200, 200),
      ),
      navigatorKey: navigatorKey, // Set the navigatorKey
      routes: {
        AuthScreen.routeName: (context) => const AuthScreen(),
        SignInScreen.routeName: (context) => const SignInScreen(),
        MainMenu.routeName: (context) => const MainMenu(),
        CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
        JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
        GameBoard.routeName: (context) => const GameBoard(),
        EmailVerification.routeName: (context) => const EmailVerification()
      },
      initialRoute: initialRoute,
    );
  }
}
