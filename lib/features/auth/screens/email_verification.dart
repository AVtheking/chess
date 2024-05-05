import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailVerification extends ConsumerStatefulWidget {
  static String routeName = "/email-verification";
  const EmailVerification({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmailVerificationState();
}

class _EmailVerificationState extends ConsumerState<EmailVerification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Enter the otp here"
            ),
          )
        ],
      ),
    );
  }
}
