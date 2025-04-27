import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/presentation/ProdutBuypage/addresschange.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/UiFunction/receipt.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Oredersummary extends StatefulWidget {
  final String documentId;

  Oredersummary({required this.documentId});

  @override
  State<Oredersummary> createState() => OrderSummaryScreen();
}

class OrderSummaryScreen extends State<Oredersummary> {
  Map<String, dynamic>? productData;
  var _razorpay = Razorpay();

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchProductData();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (productData == null) return;

    double price =
        double.tryParse(productData?['price'].toString() ?? '0') ?? 0.0;
    double total = price + 3;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReceiptPage(
                  orderId: widget
                      .documentId, // Document ID ko hi Order ID maan lenge
                  customerName:
                      "Janki Prajapati", // Ya Firestore se le sakte ho agar stored hai
                  transactionId:
                      response.paymentId ?? 'Unknown', // Razorpay se milta hai
                  totalAmount: total.toDouble(),
                  items: [
                    {
                      'name': productData?['title'] ?? 'No Title',
                      'quantity': productData?['quantity'] ?? 1,
                      'price': price,
                    },
                  ],
                )));
    // Handle success
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle error
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle wallet
  }

  Future<void> _fetchProductData() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('buy')
        .doc(widget.documentId)
        .get();

    if (snapshot.exists) {
      setState(() {
        productData = snapshot.data();
      });
      print("data fetch successfully");
    } else {
      print("Document does not exist");
    }
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _stepIndicator("Address", true),
                _stepIndicator("Order Summary", true),
                _stepIndicator("Payment", false),
              ],
            ),
            SizedBox(height: 10),
            _deliveryDetails(context),
            SizedBox(height: 15),
            _productDetails(),
            SizedBox(height: 15),
            _vipMembership(),
            SizedBox(height: 15),
            _priceDetails(),
            SizedBox(height: 15),
            _continueButton(context),
          ],
        ),
      ),
    );
  }

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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Addresschange()));
                },
                child: Text("Change", style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productDetails() {
    if (productData == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Image.network(
              productData!['image'] ?? '',
              fit: BoxFit.cover,
              width: 80,
              height: 120,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.broken_image, size: 80),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productData!['title'] ?? 'No Title',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                      'Quantity : ${productData?['quantity']?.toString() ?? '1'}'),
                  Text("₹${productData?['price'] ?? '0'}",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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

  Widget _priceDetails() {
    double price =
        double.tryParse(productData?['price'].toString() ?? '0') ?? 0.0;
    double total = price + 3;
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Price Details",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Divider(),
            _priceRow("Price (${productData?['quantity'] ?? '1'} item)",
                "₹${price.toStringAsFixed(2)}"),
            _priceRow("Platform Fee", "₹3"),
            Divider(),
            _priceRow("Total Amount", "₹${total.toStringAsFixed(2)}",
                isBold: true),
          ],
        ),
      ),
    );
  }

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

  Widget _continueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        onPressed: () {
          if (productData == null) return;

          double price =
              double.tryParse(productData?['price'].toString() ?? '0') ?? 0.0;
          double total = price + 3;

          var options = {
            'key': 'rzp_test_NHBdhCepaAeqho',
            'amount': (total * 100).toInt(),
            'name': 'MP Brand.',
            'description': productData?['title'] ?? 'No description',
            'timeout': 60,
          };
          _razorpay.open(options);
        },
        child: Text(
          "Conform Order",
          style: TextStyle(color: Colors.white, fontSize: 19),
        ),
      ),
    );
  }
}
