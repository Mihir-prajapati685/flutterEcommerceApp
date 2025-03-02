import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/bag/kids_category.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/bag/men_category.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/bag/women_category.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bag extends StatefulWidget {
  @override
  State<Bag> createState() => _BagState();
}

class _BagState extends State<Bag> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // Wrap everything inside DefaultTabController
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 70,
          title: Padding(
            padding: EdgeInsets.only(left: 70),
            child: Text(
              "Category",
              style: GoogleFonts.lato(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          bottom: TabBar(
            labelStyle: GoogleFonts.abel(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
            indicator: UnderlineTabIndicator(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(
                width: 3.0,
                // Adjust thickness of the indicator
                color: Colors.red, // Indicator color
              ),
              // Indicator width
            ),
            unselectedLabelColor: Colors.grey[600],
            tabs: [
              Tab(text: "Women"),
              Tab(text: "Men"),
              Tab(text: "Kids"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WomenCategory(),
            MenCategory(),
            KidsCategory(),
          ],
        ),
      ),
    );
  }
}
