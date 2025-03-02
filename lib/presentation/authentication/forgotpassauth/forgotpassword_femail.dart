import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; // Import for Navigator

Future<void> Forgotpassword_email(BuildContext context, emailcontroller) async {
  final FirebaseAuth auth = FirebaseAuth.instance;

  try {
    await auth.sendPasswordResetEmail(email: emailcontroller.text.toString());
    Fluttertoast.showToast(msg: "we have already send Email ");
  } catch (error) {
    print('not email sent $error');
  }
}
