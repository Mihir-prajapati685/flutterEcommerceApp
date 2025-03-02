import 'package:ecommerce_app/presentation/mainhomescreen/Main_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; // Import for Navigator

Future<void> LoginWithGoogle(BuildContext context) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount == null) {
      print("Sign-in canceled by user.");
      return; // Exit function if user cancels sign-in
    }

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    ); 
   
    UserCredential result = await auth.signInWithCredential(authCredential);
    User? user = result.user;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MainScreenState()), // Ensure HomePage exists
      );
    }
  } catch (error) {
    print("Google Sign-In Error: $error");
  }
}
