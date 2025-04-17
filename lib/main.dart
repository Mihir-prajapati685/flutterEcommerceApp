import 'package:ecommerce_app/presentation/Introduction/introduction_page.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './presentation/authentication/Loginpageauth/bloc/login_bloc_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIza....",
    authDomain: "your-project.firebaseapp.com",
    projectId: "your-project-id",
    storageBucket: "your-project.appspot.com",
    messagingSenderId: "123456789",
    appId: "1:123456789:web:abc123def456",
  ));
  runApp(
    BlocProvider(
      create: (context) => LoginBlocBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(title: ''),
      ),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static const KEYFORM = 'LOGIN';
  @override
  void initState() {
    super.initState();
    checkUserLoginStatus();
  }

  void checkUserLoginStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    var sharedPref = await SharedPreferences.getInstance();
    bool? isLoggedIn = sharedPref.getBool('isLoggedIn');
    print('current user is $user');

    if (user != null || isLoggedIn == true) {
      // User already logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreenState()),
      );
    } else {
      // User not logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IntroductionPage()),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(backgroundColor: Colors.deepOrangeAccent),
    );
  }
}
