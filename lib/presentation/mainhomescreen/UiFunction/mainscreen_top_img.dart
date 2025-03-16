import 'package:ecommerce_app/presentation/Productcartscreen/categoryWishCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopimgPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 500,
          width: double.infinity,
          child: Image.asset(
            'assets/images/splash.webp',
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.multiply,
          ),
        ),
        Positioned(
          left: 20,
          top: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Fashion\n',
                      style: GoogleFonts.radioCanada(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                    TextSpan(
                      text: 'Sale',
                      style: GoogleFonts.radioCanada(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextButton(
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>)
                  },
                  child: Text(
                    'Check',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
