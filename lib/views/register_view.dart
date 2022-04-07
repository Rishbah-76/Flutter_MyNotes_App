import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:notes/firebase_options.dart';

import 'dart:developer' as devtools show log;

import 'package:notes/constants/routes.dart';
import 'package:notes/utilites/show_error_Dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter your Email Id',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter your Password',
            ),
          ),
          TextButton(
            child: const Text("SignUp"),
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                final currentUser = FirebaseAuth.instance.currentUser;
                await currentUser?.sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
                //print(userCredential);
                //devtools.log(userCredential.toString());
              } on FirebaseAuthException catch (e) {
                devtools.log(e.code);
                if (e.code == 'weak-password') {
                  devtools.log("Weak Password");
                  await showErrorDialog(
                    context,
                    "Weak Password!!",
                  );
                } else if (e.code == 'email-already-in-use') {
                  devtools.log("Email already is use");
                  await showErrorDialog(
                    context,
                    "Email is already in use",
                  );
                } else if (e.code == 'invalid-email') {
                  devtools.log("Email is Invalid use proper Email");
                  await showErrorDialog(
                    context,
                    "Email is Invalid! Please Use Proper Email",
                  );
                } else {
                  devtools.log("Something went wrong");
                  await showErrorDialog(
                    context,
                    "Error: ${e.code}",
                  );
                }
              } catch (e) {
                await showErrorDialog(
                  context,
                  e.toString(),
                );
              }
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text("Not LoggedIn yet?Login here!"),
          )
        ],
      ),
    );
  }
}
