import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        profileImage = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Information"),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: toggleEditMode,
          )
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
                backgroundImage: NetworkImage(profileImage),
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
                onPressed: toggleEditMode,
                child: Text("Update"),
              ),
          ],
        ),
      ),
    );
  }
  
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
