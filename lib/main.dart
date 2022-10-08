import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:passport/pages/home_page.dart';
import 'package:passport/pages/sign_in.dart';
import 'package:passport/pages/sign_up.dart';
import 'package:passport/services/preference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Widget _startPage() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Preference.saveUserId(snapshot.data!.uid);
          return Home();
        } else {
          //Preference.deleteUserId();
          return SignIn();
        }
      },
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _startPage(),
      routes: {
        Home.id: (context) => Home(),
        SignUp.id: (context) => SignUp(),
        SignIn.id: (context) => SignIn(),
      },
    );
  }
}
