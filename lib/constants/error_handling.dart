import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multiplayer_chess/constants/utils.dart';

void httpErrorhandling(
    {required BuildContext context,
    required VoidCallback onSuccess,
    required http.Response response}) {
  bool success = jsonDecode(response.body)['success'];
  if (success) {
    onSuccess();
  } else {
    showSnackBar(context, jsonDecode(response.body)['message']);
  }
}
