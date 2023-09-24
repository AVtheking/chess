// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:multiplayer_chess/constants/error_handling.dart';
import 'package:multiplayer_chess/constants/utils.dart';
import 'package:multiplayer_chess/features/auth/screens/auth_screen.dart';
import 'package:multiplayer_chess/model/user.dart';
import 'package:multiplayer_chess/screen/main__menu_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userProvider = StateProvider<User?>((ref) => null);
final authServiceProvider = Provider((ref) => AuthService(ref: ref));

class AuthService {
  final Ref _ref;
  AuthService({required Ref ref}) : _ref = ref;

  void signUpUser({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
          id: '',
          name: username,
          email: email,
          password: password,
          token: '',
          type: '');

      http.Response response = await http.post(
        Uri.parse('$uri/api/signUp'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorhandling(
          context: context,
          onSuccess: () {
            showSnackBar(context, "Account Created Successfully");
            Navigator.pushNamed(context, AuthScreen.routeName);
          },
          response: response);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signIn'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorhandling(
          response: res,
          context: context,
          onSuccess: () async {
            final user = res.body;
            _ref.read(userProvider.notifier).update(
                  (state) => User.fromJson(user),
                );
            SharedPreferences pref = await SharedPreferences.getInstance();
            await pref.setString('x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushReplacementNamed(context, MainMenu.routeName);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> getUserData(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');
      if (token == null) {
        pref.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });
        _ref.read(userProvider.notifier).update(
              (state) => User.fromJson(userRes.body),
            );
      }
    } catch (e) {
      // showSnackBar(context, e.toString());
    }
  }
}
