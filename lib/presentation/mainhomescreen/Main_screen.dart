import 'package:ecommerce_app/presentation/mainhomescreen/UiFunction/mainscreen_new_item.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/UiFunction/mainscreen_offer_item.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/UiFunction/mainscreen_sale_item.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/UiFunction/mainscreen_top_img.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/UiFunction/mainscreen_topbrand_item.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/UiFunction/onbottomtab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class MainScreenState extends StatefulWidget {
  @override
  State<MainScreenState> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreenState> {
  Future<void> _handleRefresh() async {
    // 🔁 You can reload your product data here
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      // refresh the UI or call your API again
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        showChildOpacityTransition: false,
        height: 100,
        animSpeedFactor: 3.0,
        color: Colors.redAccent,
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //for top img function....
              TopimgPage(),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OfferScreen(),
                    SizedBox(
                      height: 30,
                    ),
                    MainscreenNewItem(),
                    MainscreenSaleItem(),
                    MainscreenTopbrandItem(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType
            .fixed, // ✅ Ensure all items are aligned properly
        selectedItemColor: Colors.red, // ✅ Customize selected item color
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
        ],
      ),
    );
  }
}
