import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/Orderpage/orderpage.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/paymentpage.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/promocode.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/reviewpage.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/settingspage.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/shippingpage.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => Profile_widget();
}

class Profile_widget extends State<Profile> {
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
              'My profile',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/women/44.jpg'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Matilda Brown',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'matildabrown@mail.com',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const ProfileMenuItem(
                title: 'My orders',
                subtitle: 'Already have 12 orders',
                index: 0),
            const ProfileMenuItem(
                title: 'Shipping addresses', subtitle: '3 addresses', index: 1),
            const ProfileMenuItem(
                title: 'Payment methods', subtitle: 'Visa **34', index: 2),
            const ProfileMenuItem(
                title: 'Promocodes',
                subtitle: 'You have special promocodes',
                index: 3),
            const ProfileMenuItem(
                title: 'My reviews', subtitle: 'Reviews for 4 items', index: 4),
            const ProfileMenuItem(
                title: 'Settings',
                subtitle: 'Notifications, password',
                index: 5),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Paymentpage()));
              break;
            case 3:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Promocode()));
              break;
            case 4:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Reviewpage()));
              break;
            case 5:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Settingpage()));
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
