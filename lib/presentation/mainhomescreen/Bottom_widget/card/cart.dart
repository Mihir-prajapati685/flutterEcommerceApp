import 'package:ecommerce_app/presentation/mainhomescreen/UiFunction/onbottomtab.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});
  @override
  State<Cart> createState() => _Cart_widget();
}

class _Cart_widget extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("this is cart"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType
            .fixed, // ✅ Ensure all items are aligned properly
        // ✅ Customize selected item color
        unselectedItemColor: Colors.grey, // ✅ Customize unselected item color
        showSelectedLabels: true, // ✅ Show labels always
        showUnselectedLabels: true,
        onTap: (index) => onItemTapped(
          context,
          index,
        ), // ✅ Ensure unselected labels are also visible
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.shoppingBag),
            label: "Bag",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.cartPlus),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.userCircle),
            label: "User",
          ),
        ],
      ),
    );
  }
}
