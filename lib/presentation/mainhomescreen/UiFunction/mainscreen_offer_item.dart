import 'package:ecommerce_app/presentation/Offerdetail/offer_products_screen.dart';
import 'package:flutter/material.dart'; // make sure to import your screen

class OfferScreen extends StatelessWidget {
  final List<String> offers = [
    'assets/images/offer1.png',
    'assets/images/offer2.png',
    'assets/images/offer3.png',
    'assets/images/offer4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: offers.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to OfferProductsScreen with the tapped indexz
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OfferProductsScreen(offerIndex: index),
                  ),
                );
              },
              child: Container(
                width: 350,
                height: 150,
                margin: EdgeInsets.only(
                    left: 10, right: index == offers.length - 1 ? 10 : 0),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
