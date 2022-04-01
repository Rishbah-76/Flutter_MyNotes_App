import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/firebase_options.dart';
// import 'package:notes/views/login_view.dart';
// import 'package:notes/views/register_view.dart';

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
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              //print(FirebaseAuth.instance);
              print(FirebaseAuth.instance.currentUser);
              final currentUser = FirebaseAuth.instance.currentUser;
              if (currentUser?.emailVerified ?? false) {
                print("User's Email is Verified");
              } else {
                print("User EMail is not Verified");
              }
              return const Text("done");
            default:
              return const Text("Loading...");
          }
        },
      ),
    );
  }
}
