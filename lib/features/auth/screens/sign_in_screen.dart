import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiplayer_chess/features/auth/authService.dart';
import 'package:multiplayer_chess/features/auth/screens/auth_screen.dart';

class SignInScreen extends ConsumerStatefulWidget {
  static String routeName = '/sign';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void navigateToLogIn(BuildContext context) {
    Navigator.pushNamed(context, AuthScreen.routeName);
  }

  void signUpUser(BuildContext context) {
    // var google = GoogleAuth(context: context);
    // google.handleSignIn();
    ref.watch(authServiceProvider).signUpUser(
        context: context,
        username: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  void googleSignUp(BuildContext context) async {
    ref.watch(authServiceProvider).handleSignIn(context);
  }

  @override
  Widget build(BuildContext context) {
    Color fieldColor = const Color.fromARGB(255, 132, 119, 5);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(31, 42, 42, 42),
        title: const Text(
          "Multiplayer Chess",
          style: TextStyle(fontSize: 25),
        ),
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
                        'assets/imgaes/chessBackground5.png',
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
                        " Sign Up ",
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
                                color: Color.fromARGB(255, 160, 135, 6),
                                blurRadius: 5,
                                spreadRadius: 1,
                              )
                            ]),
                            child: TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  filled: true,
                                  fillColor: fieldColor,
                                  hintText: "Enter your Username",
                                  hintStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                  border: const OutlineInputBorder(
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
                                color: Color.fromARGB(255, 180, 154, 8),
                                blurRadius: 5,
                                spreadRadius: 1,
                              )
                            ]),
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  filled: true,
                                  fillColor: fieldColor,
                                  hintText: "Enter your Email",
                                  hintStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                  border: const OutlineInputBorder(
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
                                color: Color.fromARGB(255, 160, 135, 6),
                                blurRadius: 5,
                                spreadRadius: 1,
                              )
                            ]),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: fieldColor,
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: "Enter Password",
                                  hintStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                  border: const OutlineInputBorder(
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
                        signUpUser(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 62, 138, 4),
                          minimumSize: const Size(double.infinity, 50)),
                      child: const Text(
                        "Register",
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
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        const Text(
                          "Already have an Account? ",
                          style: TextStyle(fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () => navigateToLogIn(context),
                          child: const Text(
                            "Log In",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          const Text(
                            "Login with ",
                            style: TextStyle(fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () => googleSignUp(context),
                            child: const Text(
                              "Google",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
