import 'package:ecommerce_app/Main_screen.dart';
import 'package:ecommerce_app/authenticationform/signup.dart';
import 'package:ecommerce_app/homescreenwidget/grid_item_product.dart';
import 'package:ecommerce_app/homescreenwidget/icon_list.dart';
import 'package:ecommerce_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
   ProviderScope(child:  MyApp())
     );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce Website',
      home: MyHomePage(title:''),
      debugShowCheckedModeBanner: false,
      routes: {
        '/signup_route':(context)=>Sign_up(),
      },
    );
  }
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
    whereToGo();
  }
  void whereToGo() async {
    var sharedpref = await SharedPreferences.getInstance();

    var isloginIn = sharedpref.getBool(KEYFORM);

    if (isloginIn != null) {
      if (isloginIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (contex) => MainScreenState()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (contex) => SplashScreen()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (contex) => SplashScreen()),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.amber,
        appBar:AppBar(
         backgroundColor: Colors.deepOrangeAccent,

    ),
    );
  }
}
