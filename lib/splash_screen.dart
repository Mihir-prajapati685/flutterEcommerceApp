import 'package:ecommerce_app/authenticationform/Login_button.dart';
import 'package:ecommerce_app/authenticationform/signup.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => Splash_screen();
}

class Splash_screen extends State<SplashScreen> {
  var _height = double.infinity;
  var _width = double.infinity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: _height,
            height: _width,
              child: Image.asset(
                "assets/images/splash.webp",
                fit: BoxFit.cover,
              ),
          ),
          Positioned(
            left: 150,
            top: 380,
            child: Text(
              'LaGio',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 45,
                color: Colors.white60,
              ),
            ),
          ),
          Positioned(
            left: 100,
            top: 470,
            child: Container(
              width: 250,
              height: 200,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "ELEVATE IN YOUR UNIQUE  ",
                      style: TextStyle(color: Colors.white60, fontSize: 45),
                    ),
                    TextSpan(
                      text: "STYLE .",
                      style: TextStyle(color: Colors.orange[600], fontSize: 45),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 30,
            top: 700,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepOrangeAccent, Colors.white60],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                           MaterialPageRoute(builder: (context) => Sign_up()),
                        );
                      },
                      child: Text(
                        'SignUp',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 130,
                          vertical: 10,
                        ),
                      ),
                    ),

                ),
                SizedBox(height: 20),
                Container(

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white60, Colors.deepOrangeAccent],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Hero(
                    tag: 'button1',
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context,animation,secondaryAnimation)=>Login_button(),
                            transitionsBuilder: (context,animation,secondaryAnimation,child){
                              var begin=Offset(1.0,0.0);
                              var end=Offset.zero;
                              var curve=Curves.bounceIn;
                              var tween=Tween(begin: begin,end: end).chain(CurveTween(curve: curve));
                              var offsetanimation=animation.drive(tween);
                              return SlideTransition(position: offsetanimation,child: child,);
                            },
                          ),
                          // MaterialPageRoute(builder: (context) => Sign_up()),
                        );
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 130,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )

          ),
          Positioned(
            top: 780,
            left: 120,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Already Have Account? ",
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "LOGIN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
