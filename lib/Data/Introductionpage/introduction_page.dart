import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

List<PageViewModel> getPages() {
  return [
    PageViewModel(
      image: Center(
        child: Container(
          width: 350, // Adjust size as needed
          height: 350,
          child: Image.network(
            "https://www.tranktechnologies.com/assets/new-assets/services/app-dev/ecomm-usa/ecomm-banner-texas.webp",
            fit: BoxFit.cover, // Ensures the image fills the circular frame
          ),
        ),
      ),
      titleWidget: Center(
        child: Text(
          "Easy Shopping",
          style: GoogleFonts.robotoCondensed(fontSize: 45, color: Colors.black),
        ),
      ),
      bodyWidget: Center(
        child: Text(
          "Enjoy a smooth and hassle-free shopping experience with just a few taps Find your favorite products easily and shop anytime, anywhere.Discover a wide range of products with a simple and intuitive interface.",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700]),
        ),
      ),
    ),

    PageViewModel(
      image: Center(
        child: Container(
          width: 350, // Adjust size as needed
          height: 350,
          child: Image.network(
            "https://img.freepik.com/premium-photo/secure-browsing-concept-as-safe-path-through-web-with-white-background-isolated-cute-cartoon_980716-70990.jpg?w=360",
            fit: BoxFit.cover, // Ensures the image fills the circular frame
          ),
        ),
      ),

      titleWidget: Center(
        child: Text(
          "Secure Payment",
          style: GoogleFonts.robotoCondensed(fontSize: 45, color: Colors.black),
        ),
      ),
      bodyWidget: Center(
        child: Text(
          'Enjoy worry-free transactions with our encrypted and secure payment gateway.Multiple payment options with end-to-end security for your peace of mind.Fast, reliable, and 100% secure payment methods for a seamless checkout experience.',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700]),
        ),
      ),
    ),

    PageViewModel(
      image: Center(
        child: Container(
          width: 350, // Adjust size as needed
          height: 350,
          child: Image.network(
            "https://static.vecteezy.com/system/resources/previews/023/743/919/non_2x/courier-delivery-man-holding-parcel-box-with-mobile-phone-fast-online-delivery-service-online-ordering-internet-e-commerce-ideas-for-websites-or-banners-3d-perspective-illustration-free-png.png",
            fit: BoxFit.cover, // Ensures the image fills the circular frame
          ),
        ),
      ),

      titleWidget: Center(
        child: Text(
          "Quick Delivery",
          style: GoogleFonts.robotoCondensed(fontSize: 45, color: Colors.black),
        ),
      ),
      bodyWidget: Center(
        child: Text(
          'Swift and reliable delivery right to your doorstep.We ensure speedy delivery so you can enjoy your products sooner.Fast shipping with real-time tracking for a hassle-free experience.',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700]),
        ),
      ),
    ),
  ];
}
