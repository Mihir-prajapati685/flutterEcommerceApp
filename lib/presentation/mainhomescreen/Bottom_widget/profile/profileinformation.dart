import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class PersonalInfoScreen extends StatefulWidget {
  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  bool isEditing = false;
  String username = "John Doe";
  String email = "johndoe@example.com";
  String password = "********"; // Hide actual password
  String profileImage = "https://via.placeholder.com/150"; // Placeholder image

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    usernameController.text = username;
    emailController.text = email;
    passwordController.text = password;
    _fetchUserData();
  }

  // Function to fetch user data from Firestore
  Future<void> _fetchUserData() async {
    try {
      // Get current user's email from FirebaseAuth
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print("No user is logged in");
        return;
      }

      String userEmail = currentUser.email!;

      // Fetch the user document from Firestore
      final snapshot = await FirebaseFirestore.instance
          .collection('signincollection')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var userDoc = snapshot.docs.first;

        setState(() {
          username = userDoc['username'] ?? 'Unknown';
          email = userDoc['email'] ?? 'No email found';
          password = userDoc['password'] ?? '********';
          profileImage =
              userDoc['profileImage'] ?? "https://via.placeholder.com/150";
          usernameController.text = username;
          emailController.text = email;
          passwordController.text = password;
        });
      } else {
        print("No user data found for this email");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  // Function to pick a new image for profile
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Update the profile image immediately with the local image path
      setState(() {
        profileImage = pickedFile.path;
      });
    }
  }

  // Function to upload the picked image to Firebase Storage and get the URL
  Future<String?> uploadImageToFirebase(File imageFile) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage
          .ref()
          .child('profile_images/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = ref.putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  // Function to update the user data in Firestore
  Future<void> updateUserData() async {
    try {
      // Get current user's email from FirebaseAuth
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print("No user is logged in");
        return;
      }

      String userEmail = currentUser.email!;

      String? uploadedImageUrl = profileImage.startsWith('http')
          ? profileImage // Use existing URL if no new image is selected
          : await uploadImageToFirebase(
              File(profileImage)); // Upload new image if selected

      // Update user document in Firestore
      await FirebaseFirestore.instance
          .collection('signincollection')
          .doc(userEmail) // Use email as document ID or you can use UID
          .update({
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'profileImage': uploadedImageUrl ??
            profileImage, // Use the new or existing profile image URL
      });

      setState(() {
        // Save updated data
        username = usernameController.text;
        email = emailController.text;
        password = passwordController.text;
      });

      print("User data updated successfully");
    } catch (e) {
      print("Error updating user data: $e");
    }
  }

  void toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
      if (!isEditing) {
        // Save changes when switching back
        username = usernameController.text;
        email = emailController.text;
        password = passwordController.text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Information"),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              if (isEditing) {
                updateUserData(); // Update data when in edit mode
              }
              toggleEditMode(); // Toggle edit mode
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: isEditing
                  ? pickImage
                  : null, // Allow image change in edit mode
              child: CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(File(profileImage)),
                child: isEditing
                    ? Icon(Icons.camera_alt, color: Colors.white, size: 30)
                    : null,
              ),
            ),
            SizedBox(height: 20),
            buildTextField("Username", usernameController),
            buildTextField("Email", emailController),
            buildTextField("Password", passwordController, isPassword: true),
            if (isEditing)
              ElevatedButton(
                onPressed: () {
                  updateUserData(); // Update the data when clicked on update
                },
                child: Text("Update"),
              ),
          ],
        ),
      ),
    );
  }

  // Widget to build text fields for user input
  Widget buildTextField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        readOnly: !isEditing,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
