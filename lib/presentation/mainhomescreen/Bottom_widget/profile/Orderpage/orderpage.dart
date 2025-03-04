import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/Orderpage/cancelOrder.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/Orderpage/deliveredOrder.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/Orderpage/processingOrder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderPage extends StatefulWidget {
  @override
  State<OrderPage> createState() => _OrderPage();
}

class _OrderPage extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, left: 30),
              child: Text(
                'My Order',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black),
              ),
            ),

            SizedBox(height: 20), // Adds spacing between AppBar and Tabs
            TabBar(
              padding: EdgeInsets.only(left: 10, right: 10),
              labelStyle: GoogleFonts.abel(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: UnderlineTabIndicator(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  width: 45, // Adjust thickness of the indicator
                  color: Colors.black,
                  // Indicator color
                ),
              ),
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: "Delivered"),
                Tab(text: "Processing"),
                Tab(text: "Cancelled"),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Deliveredorder(),
                  Processingorder(),
                  CancelOrder(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
