import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalInfoScreen extends StatefulWidget {
  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  String username = "Loading...";
  String email = "Loading...";
  String password = "********";

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Function to fetch user data from Firestore
  Future<void> _fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      print("🔍 FirebaseAuth.currentUser: $user");
      if (user == null) {
        print("No user logged in! Please sign in first.");
        return;
      }

      String uid = user.uid;
      print("Logged-in User UID: $uid");

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('signincollection')
          .where('uid', isEqualTo: uid) // 🔥 Match 'uid' field in Firestore
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // 🔥 Get the first matching document
        DocumentSnapshot userdoc = querySnapshot.docs.first;
        print("Document ID found: ${userdoc.id}");
        print("Document Data: ${userdoc.data()}");

        Map<String, dynamic>? userdata =
            userdoc.data() as Map<String, dynamic>?;

        if (userdata != null) {
          print(userdata);
          setState(() {
            username = (userdata['username'] ?? '').toString().trim();
            email = (userdata['email'] ?? '').toString().trim();
            password = (userdata['password'] ?? '********').toString().trim();

            print("sucessfully geting");
          });
        } else {
          print("Error: Document exists but has no data!");
        }
      } else {
        print("Error: No document found for this user!");
      }
    } catch (e) {
      print("Error fetching profile data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personal Information")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueAccent,
              child: Text(
                username.isNotEmpty ? username[0].toUpperCase() : "?",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            buildDisplayField("username", username),
            buildDisplayField("email", email),
            buildDisplayField("password", password),
          ],
        ),
      ),
    );
  }
  Widget buildDisplayField(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
       
        decoration: InputDecoration(
          labelText: label,
          hintText:value,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
