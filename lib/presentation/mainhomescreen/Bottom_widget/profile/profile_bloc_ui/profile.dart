import 'package:ecommerce_app/presentation/authentication/Signuppageauth/signup.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/Orderpage/orderpage.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/profileinformation.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/profile_bloc_ui/bloc/profile_bloc.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/reviewpage.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/settingspage.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/profile_bloc_ui/Shippingaddresspage/shippingpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => Profile_widget();
}

class Profile_widget extends State<Profile> {
  final ProfileBloc profileBloc = ProfileBloc();

  @override
  void initState() {
    super.initState();
    profileBloc.add(ProfilePageInitialEvent());
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
              bloc: profileBloc,
              builder: (context, state) {
                if (state is ProfileDataFromTheFirebaseErrorState) {
                  return Text("Error loading profile data");
                } else if (state is ProfileDataFromTheFirebaseState) {
                  var data = state.profiledata; // Fetch single user data
                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(data['img'] ?? ""),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['name'] ?? "No Name",
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
                } else if (state is ProfileDataFromTheFirebaseDataNOtState) {
                  return Text('Error data fetch');
                }
                return CircularProgressIndicator(); // Show loader while fetching data
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
            : SizedBox(),
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
              Fluttertoast.showToast(msg: 'Log Out SucessFully');
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Sign_up()));
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
