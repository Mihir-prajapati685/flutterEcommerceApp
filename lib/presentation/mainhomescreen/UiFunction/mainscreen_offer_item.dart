import 'package:flutter/material.dart';

class OfferScreen extends StatelessWidget {
  final List<String> offers = [
    'assets/images/offer1.png',
    'assets/images/offer1.png',
    'assets/images/offer1.png',
    'assets/images/offer1.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 200, // Adjust based on design
        child: ListView.builder(
          scrollDirection: Axis.horizontal, // Horizontal scroll
          itemCount: offers.length,
          itemBuilder: (context, index) {
            return Container(
              width: 350,
              height: 150,
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  offers[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
