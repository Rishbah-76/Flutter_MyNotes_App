import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/views/login_view.dart';
import 'package:notes/views/register_view.dart';

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
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
      },
    ),
  );
}

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
            print(FirebaseAuth.instance);
            //print(FirebaseAuth.instance.currentUser);

            // final currentUser = FirebaseAuth.instance.currentUser;
            // if (currentUser?.emailVerified ?? false) {
            //   //print("User's Email is Verified");
            //   return const LoginView();

            // } else {

            //Loading the context directly not navigating as of now...

            // return const VerifyEmailView();

            //print("User EMail is not Verified");
            // }

            //return const Text("done");
            return const LoginView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
