import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:notes/firebase_options.dart';

import 'dart:developer' as devtools show log;

import 'package:notes/constants/routes.dart';
import 'package:notes/utilites/show_error_Dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Text("Login"),
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
            child: const Text("Login"),
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                //final userCredential =
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                final currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser?.emailVerified ?? false) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                    (route) => false,
                  );
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    verifyEmailRoute,
                    (route) => false,
                  );
                }
                //print(userCredential);
                // } catch (e) { //Catch All
                //   print("soemthing went wrong");
                //   print(e.runtimeType);
                //devtools.log(userCredential.toString());
              } on FirebaseAuthException catch (e) {
                //print(e.code);
                devtools.log(e.code);
                if (e.code == 'user-not-found') {
                  await showErrorDialog(
                    context,
                    "User Does Not Exit! Register First",
                  );
                  //print("User does not found");
                  devtools.log('User Not Found');
                } else if (e.code == 'Wrong password') {
                  devtools.log('Wrong password');
                  await showErrorDialog(
                    context,
                    "Wrong Password!!",
                  );
                } else {
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
                registerRoute,
                (route) => false,
              );
            },
            child: const Text("Not registered yet?Register here!"),
          )
        ],
      ),
    );
  }
}
