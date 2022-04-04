import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Please verify your email address"),
        TextButton(
          onPressed: () async {
            final currentUser = FirebaseAuth.instance.currentUser;
            await currentUser?.sendEmailVerification();
          },
          child: const Text("Verify Email"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              "/login/",
              (route) => false,
            );
          },
          child: const Text("ALredy Verified?Login here!"),
        )
      ],
    );
  }
}
