//ignore
// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:multiplayer_chess/constants/error_handling.dart';
import 'package:multiplayer_chess/constants/utils.dart';
import 'package:multiplayer_chess/features/auth/screens/email_verification.dart';
import 'package:multiplayer_chess/model/user.dart';
import 'package:multiplayer_chess/screen/main__menu_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userProvider = StateProvider<User?>((ref) => null);
final authServiceProvider = Provider((ref) => AuthService(
      ref: ref,
    ));

class AuthService {
  final Ref _ref;
  BuildContext? context;
  AuthService({required Ref ref, this.context}) : _ref = ref;
  var headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  setTokens(String accessToken, String refreshToken) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('x-auth-access_token', accessToken);
    pref.setString('x-auth-refresh_token', refreshToken);
  }

  clearToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('x-auth-access_token', '');
    pref.setString('x-auth-refresh_token', '');
  }

  setUser(http.Response response) {
    var data = jsonDecode(response.body);

    User user = User.fromMap(data['data']['user']);

    _ref.read(userProvider.notifier).update(
          (state) => User.fromJson((user.toJson())),
        );
    String? accessToken = data['data']['accessToken'];
    String? refreshToken = data['data']['refreshToken'];
    if (accessToken != null && refreshToken != null) {
      setTokens(accessToken, refreshToken);
    }
  }

//checking whether the token is expired or not
  checkAuthExpiry(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('x-auth-access_token');
    if (token == null || token.isEmpty) {
      return;
    }
    if (JwtDecoder.isExpired(token)) {
      //if the token is expired refresh the token
      refreshToken(context);
    }
  }

  void refreshToken(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? refreshToken = pref.getString('x-auth-refresh_token');

    if (refreshToken == null || refreshToken.isEmpty) {
      clearToken();
    }
    if (JwtDecoder.isExpired(refreshToken!)) {
      clearToken();
      return;
    }
    http.Response response = await http.post(
        Uri.parse('$uri/api/v1/auth/refreshToken'),
        body: jsonEncode({'refreshToken': refreshToken}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $refreshToken"
        });
    httpErrorhandling(
        context: context,
        onSuccess: () {
          var data = jsonDecode(response.body);
          var accessToken = data['data']['accessToken'];
          pref.setString('x-auth-access_token', accessToken);
        },
        response: response);
  }

  void signUpUser({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        username: username,
        email: email,
        password: password,
      );

      http.Response response = await http.post(
          Uri.parse('$uri/api/v1/auth/signUp'),
          body: user.toJson(),
          headers: headers);

      httpErrorhandling(
          context: context,
          onSuccess: () {
            showSnackBar(context, "Account Created Successfully");
            Navigator.pushNamed(context, EmailVerification.routeName);
          },
          response: response);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void emailVerfication(
      {required BuildContext context,
      required String email,
      required int otp}) async {
    try {
      var body = jsonEncode({"email": email, "otp": otp});

      http.Response response = await http.post(
          Uri.parse('$uri/api/v1/auth/verifyEmail'),
          body: body,
          headers: headers);

      httpErrorhandling(
          context: context,
          onSuccess: () async {
            setUser(response);
            showSnackBar(context, "User Signed In successfully");
            Navigator.pushReplacementNamed(context, MainMenu.routeName);
          },
          response: response);
    } catch (error) {
      print(error);
      showSnackBar(context, "Error occured");
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/v1/auth/signIn'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorhandling(
          response: res,
          context: context,
          onSuccess: () async {
            setUser(res);
            Navigator.pushReplacementNamed(context, MainMenu.routeName);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> getUserData(BuildContext context) async {
    try {
      checkAuthExpiry(context);
      print('------------------------------here');
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-access_token');
      if (token == null || token.isEmpty) {
        print('===============no token');
        pref.setString('x-auth-access_token', '');
        return;
      }
      print('#######################-------------$token');

      http.Response userRes = await http
          .get(Uri.parse('$uri/api/v1/users'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      });

      httpErrorhandling(
          context: context,
          onSuccess: () {
            setUser(userRes);
          },
          response: userRes);

      setUser(userRes);
    } catch (e) {
      print('============================$e');
      // showSnackBar(context, e.toString());
    }
  }

  void handleSignIn(BuildContext context) async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      print(googleSignInAuthentication);
      final String accessToken = googleSignInAuthentication.accessToken!;

      print(accessToken);
      await exchangeTokenWithBackend(context, accessToken);
    } catch (error) {
      print(error);
    }
  }

  Future<void> exchangeTokenWithBackend(
      BuildContext context, String accessToken) async {
    String? baseURL = uri;
    try {
      print("here");
      http.Response res = await http.post(
          Uri.parse('$baseURL/api/v1/auth/exchange/'),
          body: {'access_token': accessToken});

      httpErrorhandling(
          context: context,
          response: res,
          onSuccess: () async {
            setUser(res);
            showSnackBar(context, "User Signed In successfully");
            Navigator.pushReplacementNamed(context, MainMenu.routeName);
          });
      Navigator.pushReplacementNamed(context, MainMenu.routeName);
    } catch (error) {
      print(error);
    }
  }
}
