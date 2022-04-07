import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/constants/routes.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/views/login_view.dart';
import 'package:notes/views/register_view.dart';
import 'package:notes/views/verify_email_view.dart';
import 'dart:developer' as devtools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
      },
    ),
  );
}

enum MenuAction { logout }

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            //print(FirebaseAuth.instance);
            //print(FirebaseAuth.instance.currentUser);

            final currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser != null) {
              if (currentUser.emailVerified) {
                //print("Email is verified");
                devtools.log("Email is verified");
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
            //return const Text("done");
            //return const LoginView();
            return const NotesView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main UI"),
        actions: [
          PopupMenuButton(
            onSelected: (value) async {
              //print("$value is selected");
              devtools.log(value.toString());
              switch (value) {
                case MenuAction.logout:
                  final shouldLogOut = await showLogOutDialogBox(context);
                  devtools.log(shouldLogOut.toString());
                  if (shouldLogOut) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/login/", (route) => false);
                  }
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  child: Text("Logout"),
                  value: MenuAction.logout,
                ),
              ];
            },
          )
        ],
      ),
      //Adding just for checking up
    );
  }
}

Future<bool> showLogOutDialogBox(BuildContext context) {
  return showDialog(
    context: context,
    builder: (contex) {
      return AlertDialog(
        title: const Text("Log out"),
        content: const Text("Are yout sure you want to log out"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("Sure"),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
