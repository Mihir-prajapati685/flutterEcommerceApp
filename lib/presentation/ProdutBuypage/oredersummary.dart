import 'package:ecommerce_app/presentation/ProdutBuypage/addresschange.dart';
import 'package:ecommerce_app/presentation/ProdutBuypage/paymentlastpage.dart';
import 'package:flutter/material.dart';

class OrderSummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Summary"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _stepIndicator("Address", true),
                _stepIndicator("Order Summary", true),
                _stepIndicator("Payment", false),
              ],
            ),
            SizedBox(height: 10),

            // Delivery Details
            _deliveryDetails(context),

            SizedBox(height: 15),

            // Product Details
            _productDetails(),

            SizedBox(height: 15),

            // VIP Membership
            _vipMembership(),

            SizedBox(height: 15),

            // Price Details
            _priceDetails(),

            SizedBox(height: 15),

            // Continue Button
            _continueButton(context),
          ],
        ),
      ),
    );
  }

  // Step Indicator Widget
  Widget _stepIndicator(String title, bool isCompleted) {
    return Column(
      children: [
        Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isCompleted ? Colors.red : Colors.grey,
        ),
        Text(title, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  // Delivery Details Widget
  Widget _deliveryDetails(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Deliver to:", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text("Janki Prajapati",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text("54 Ayodhya Dham, Nani Kadi, near Krishna Flat, Kadi 382715"),
            Text("7069737512"),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Addresschange()));
                  },
                  child: Text(
                    "Change",
                    style: TextStyle(color: Colors.red),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  // Product Details Widget
  Widget _productDetails() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Image.network(
              "https://gratisography.com/wp-content/uploads/2024/11/gratisography-augmented-reality-800x525.jpg",
              fit: BoxFit.cover, // Replace with actual image URL
              width: 80,
              height: 120,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Earbuds Nano Glass for JBL TOUR P...",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text("Pack of 2"),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.green, size: 14),
                      Text(" 3.2 (31)"),
                    ],
                  ),
                  Text("₹196",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text("₹1,399",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough)),
                      SizedBox(width: 5),
                      Text("85% off", style: TextStyle(color: Colors.green)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text("Delivery by Mar 12, Wed • FREE",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // VIP Membership Widget
  Widget _vipMembership() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.verified, color: Colors.amber),
                SizedBox(width: 5),
                Text("Get VIP membership"),
              ],
            ),
            Text("And enjoy savings worth ₹13.0 now!"),
            TextButton(onPressed: () {}, child: Text("See all benefits")),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("₹499 for 12 months"),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Buy VIP"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Price Details Widget
  Widget _priceDetails() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Price Details",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Divider(),
            _priceRow("Price (1 item)", "₹1,399"),
            _priceRow("Discount", "-₹1,203", color: Colors.green),
            _priceRow("Platform Fee", "₹3"),
            Divider(),
            _priceRow("Total Amount", "₹199", isBold: true),
          ],
        ),
      ),
    );
  }

  // Price Row Widget
  Widget _priceRow(String label, String amount,
      {bool isBold = false, Color color = Colors.black}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(amount,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  color: color)),
        ],
      ),
    );
  }

  // Continue Button Widget
  Widget _continueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PaymentLastPage()));
        },
        child: Text(
          "CONTINUE",
          style: TextStyle(color: Colors.white, fontSize: 19),
        ),
      ),
    );
  }
}
