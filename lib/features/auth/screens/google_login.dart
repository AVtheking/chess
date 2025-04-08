// // ignore_for_file: avoid_print

// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import 'package:multiplayer_chess/constants/error_handling.dart';
// import 'package:multiplayer_chess/constants/utils.dart';
// import 'package:multiplayer_chess/model/user.dart';

// class GoogleAuth {
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   BuildContext? context;
//   GoogleAuth({required this.context});

//   Future<void> handleSignIn() async {
//     try {
//       final GoogleSignInAccount? googleSignInAccount =
//           await _googleSignIn.signIn();

//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount!.authentication;

//       print(googleSignInAuthentication);
//       final String accessToken = googleSignInAuthentication.accessToken!;

//       print(accessToken);
//       await exchangeTokenWithBackend(accessToken);
//     } catch (error) {
//       print("-----------------++++++++++++++++----------------------------");
//       print(error);
//       print(
//           "-----------------+++++++++++++++++++++----------------------------");
//     }
//   }

//   Future<void> exchangeTokenWithBackend(String accessToken) async {
//     String? baseURL = uri;
//     try {
//       http.Response res = await http.post(
//           Uri.parse('$baseURL/api/v1/auth/exchange/'),
//           body: {'access_token': accessToken});

//       var data = jsonDecode(res.body);
//       print(data['data']['user']);

//       User user = User.fromMap(data['data']['user']);
//       print("${user.toJson()}--------------------------------------");
//       httpErrorhandling(
//           context: this.context!, response: res, onSuccess: () async {
            
//           });
//     } catch (error) {
//       print(error);
//     }
//   }

//   void signOut() async {
//     await _googleSignIn.signOut();
//   }
// }
