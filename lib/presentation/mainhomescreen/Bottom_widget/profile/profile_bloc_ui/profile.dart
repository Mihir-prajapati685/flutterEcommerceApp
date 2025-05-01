import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/presentation/authentication/Signuppageauth/signup.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/Orderpage/orderpage.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/profileinformation.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/profile_bloc_ui/bloc/profile_bloc.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/reviewpage.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/settingspage.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/profile_bloc_ui/Shippingaddresspage/shippingpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc()..add(ProfilePageInitialEvent()),
      child: ProfileContent(),
    );
  }
}

class ProfileContent extends StatefulWidget {
  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  File? _pickedImage;

  Future<void> _pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        // Upload to Firebase Storage
        final user = FirebaseAuth.instance.currentUser;
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_profile_images')
            .child('${user!.uid}.jpg');

        await storageRef.putFile(imageFile);

        // Get download URL
        String downloadURL = await storageRef.getDownloadURL();

        // Update Firestore user document
        await FirebaseFirestore.instance
            .collection('signincollection')
            .doc(user.uid)
            .update({'img': downloadURL});

        setState(() {
          _pickedImage = imageFile;
        });

        Fluttertoast.showToast(msg: 'Profile Image Updated!');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Profile not updated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Profile',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(height: 30),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileDataFromTheFirebaseErrorState) {
                  return Text("Error loading profile data");
                } else if (state is ProfileDataFromTheFirebaseDataNOtState) {
                  return Text("No user found. Please login again.");
                } else if (state is ProfileDataFromTheFirebaseState) {
                  var data = state.profiledata;
                  return Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: _pickedImage != null
                                ? FileImage(_pickedImage!)
                                : NetworkImage(data['img'] ?? "")
                                    as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _pickImageFromGallery,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['username'] ?? "No Name",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            data['email'] ?? "No Email",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            SizedBox(height: 20),
            const ProfileMenuItem(
                title: 'My Orders',
                subtitle: 'Already have 12 orders',
                index: 0),
            const ProfileMenuItem(
                title: 'Shipping Addresses', subtitle: '3 addresses', index: 1),
            const ProfileMenuItem(
                title: 'Profile Information', subtitle: 'mihir**34', index: 2),
            const ProfileMenuItem(
                title: 'My Reviews', subtitle: 'Reviews for 3 Items', index: 3),
            const ProfileMenuItem(
                title: 'Settings',
                subtitle: 'Notifications password',
                index: 4),
            const ProfileMenuItem(title: 'Log Out', subtitle: '', index: 5),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final int index;

  const ProfileMenuItem({
    required this.title,
    required this.subtitle,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: title == "Log Out"
            ? Icon(
                Icons.logout_outlined,
                color: Colors.red,
              )
            : null,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          switch (index) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderPage()));
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Shippingpage()));
              break;
            case 2:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PersonalInfoScreen()));
              break;
            case 3:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Reviewpage()));
              break;
            case 4:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Settingpage()));
              break;
            case 5:
              Fluttertoast.showToast(msg: 'Log Out Successfully');
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Sign_up()));
              break;
          }
        },
      ),
    );
  }
}
