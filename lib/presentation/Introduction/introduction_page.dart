import 'package:ecommerce_app/Data/Introductionpage/introduction_page.dart';
import 'package:ecommerce_app/presentation/authentication/Signuppageauth/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionPage extends StatefulWidget {
  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: IntroductionScreen(
        done: Text('Done', style: TextStyle(color: Colors.black)),
        onDone: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Sign_up()),
          );
        },
        pages: getPages(),
        skip: const Text(
          // ✅ Skip button yahan hona chahiye
          "Skip",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        next: Text(
          // ✅ Next button ke liye ye hona chahiye
          "Next",
          style: GoogleFonts.farro(
            fontSize: 16,
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        globalBackgroundColor: Colors.grey[100],
        dotsDecorator: DotsDecorator(
          color: Colors.red[400]!,
          activeColor: Colors.red[400]!,
          size: const Size.square(8.0),
          activeSize: const Size(12.0, 12.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),

        dotsFlex: 2, // Dots left side pe shift karne ke liye
        nextFlex: 1, // Next button ko adjust karne ke liye
        // ✅ Skip button ko enable karna
      ),
    );
  }
}
