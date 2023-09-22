import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiplayer_chess/features/auth/authService.dart';
import 'package:multiplayer_chess/features/auth/screens/sign_in_screen.dart';

class AuthScreen extends ConsumerStatefulWidget {
  static String routeName = '/auth';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreeenState();
}

class _AuthScreeenState extends ConsumerState<AuthScreen> {
  // final TextEditingController _nameController=TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void navigateToSignIn(BuildContext context) {
    Navigator.pushNamed(context, SignInScreen.routeName);
  }

  @override
  void dispose() {
// _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void logInUser(BuildContext context) {
    ref.watch(authServiceProvider).signInUser(
        context: context,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(31, 42, 42, 42),
        title: const Text(
          "Multiplayer Chess",
          style: TextStyle(fontSize: 25),
        ),
        // centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: size.height * 0.9, maxWidth: 500),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                        'assets/imgaes/chessBackground.png',
                        fit: size.width > 500 ? BoxFit.cover : BoxFit.contain,
                        width: double.infinity,
                        height: size.width > 500
                            ? size.height * 0.4
                            : size.height * 0.3,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Start your journey ",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.green, blurRadius: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.green,
                                blurRadius: 5,
                                spreadRadius: 1,
                              )
                            ]),
                            child: TextField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 71, 106, 6),
                                  hintText: "Enter your Email",
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.green,
                                blurRadius: 5,
                                spreadRadius: 1,
                              )
                            ]),
                            child: TextField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 71, 106, 6),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: "Enter Password",
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        logInUser(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 193, 188, 188),
                          minimumSize: const Size(double.infinity, 50)),
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                            fontSize: 23,
                            color: Color.fromARGB(255, 60, 100, 5),
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  color: Color.fromARGB(255, 186, 168, 7),
                                  blurRadius: 5)
                            ]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        const Text(
                          "Don't have an Account? ",
                          style: TextStyle(fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () => navigateToSignIn(context),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
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
