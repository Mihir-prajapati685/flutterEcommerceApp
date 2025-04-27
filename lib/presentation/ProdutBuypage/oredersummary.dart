import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/presentation/ProdutBuypage/addresschange.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/UiFunction/receipt.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Map<String, dynamic>?
      finalAddressData; // Variable to store final address data
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
    _fetchFinalAddressData(); // Fetch final address data when page initializes
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  // Fetch current user's data from the finaladdress collection
  Future<void> _fetchFinalAddressData() async {
    try {
      // Get the current user's UID
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print("No user is logged in");
        return;
      }

      String userId = currentUser.uid;
      print("Fetching final address for user UID: $userId");

      // Fetch the address from the "finaladdress" collection
      final snapshot = await FirebaseFirestore.instance
          .collection('finaladdress')
          .where('uid', isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Assuming the final address is stored in the first document
        setState(() {
          finalAddressData = snapshot.docs[0].data();
        });
        print("Final address fetched successfully");
      } else {
        print("No final address found for this user");
      }
    } catch (e) {
      print("Error fetching final address: $e");
    }
  }

  Future<void> _updateAddress() async {
    final selectedAddress = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Addresschange()),
    );

    if (selectedAddress != null) {
      setState(() {
        finalAddressData =
            selectedAddress; // Update the address with the selected one
      });
    }
  }

  // Handle payment success
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (productData == null) return;

    double price =
        double.tryParse(productData?['price'].toString() ?? '0') ?? 0.0;
    double total = price + 3;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReceiptPage(
                  orderId: widget.documentId, // Document ID as Order ID
                  customerName:
                      "Janki Prajapati", // Placeholder, can fetch from Firestore
                  transactionId:
                      response.paymentId ?? 'Unknown', // Razorpay payment ID
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
    // Handle payment error
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
  }

  // Fetch product data
  Future<void> _fetchProductData() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('buy')
        .doc(widget.documentId)
        .get();

    if (snapshot.exists) {
      setState(() {
        productData = snapshot.data();
      });
      print("Product data fetched successfully");
    } else {
      print("Document does not exist");
    }
  }

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

  // Step indicator widget
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

  // Delivery details widget
  Widget _deliveryDetails(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Deliver to:", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(finalAddressData != null
                ? finalAddressData!['fullName'] ?? 'No Name'
                : 'No Address'),
            Text(finalAddressData != null
                ? finalAddressData!['address'] ?? 'No Address'
                : 'No Address'),
            Text(finalAddressData != null
                ? finalAddressData!['phoneNumber'] ?? 'No Phone'
                : 'No Phone'),
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
