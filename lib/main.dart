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
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase only if it's not already initialized
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBxdD72FG0xo6UZJAfphpoIp7rDxmUdds4",
          authDomain: "ecommerceproject-7b81e.firebaseapp.com",
          databaseURL:
              "https://ecommerceproject-7b81e-default-rtdb.firebaseio.com",
          projectId: "ecommerceproject-7b81e",
          storageBucket: "ecommerceproject-7b81e.firebasestorage.app",
          messagingSenderId: "40092228276",
          appId: "1:40092228276:web:12df5d1d88dbab9befd5e1",
          measurementId: "G-BMZ17ED0YT"),
    );
  }
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
    print('Current user: $user');

    if (user != null || isLoggedIn == true) {
      // User already logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MainScreenState()), // Make sure to use MainScreen directly
      );
    } else {
      // User not logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IntroductionPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(backgroundColor: Colors.deepOrangeAccent),
    );
  }
}
