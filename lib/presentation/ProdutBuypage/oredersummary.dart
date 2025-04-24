import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/presentation/ProdutBuypage/addresschange.dart';
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
  @override
  var _razorpay = Razorpay();

  void dispose() {
    _razorpay.clear();
  }

  void initState() {
    super.initState();
    _fetchProductData();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
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
      print("data fetch sucessfully");
    } else {
      print("nai aave tarathi thay e kari le");
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
    if (productData == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Image.network(
              productData!['image'] ?? '', // assuming field name is 'image'
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
                  Text('Quantity : ${productData!['quantity'] ?? '1'}'),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.green, size: 14),
                      Text(" ${productData!['rating'] ?? '4.0'}"),
                    ],
                  ),
                  Text("₹${productData!['price'] ?? '0'}",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text("₹${productData!['originalPrice'] ?? '0'}",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough)),
                      SizedBox(width: 5),
                      Text("${productData!['discountPercent'] ?? '0%'} off",
                          style: TextStyle(color: Colors.green)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Delivery by ${productData!['deliveryDate'] ?? 'N/A'}",
                    style: TextStyle(color: Colors.grey),
                  ),
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
    var total = productData!['price'] + 3;
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Price Details",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Divider(),
            _priceRow("Price (${productData!['quantity'] ?? '1'}item)",
                "₹${productData!['price'] ?? '0'}"),
            _priceRow("Discount", "₹${productData!['discountPercent'] ?? '0'}",
                color: Colors.green),
            _priceRow("Platform Fee", "₹3"),
            Divider(),
            _priceRow("Total Amount", "₹${total}", isBold: true),
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
          if (productData == null) return;

          int price = productData!['price'] ?? 0;
          int platformFee = 3;
          int total = price + platformFee;
          var options = {
            'key': 'rzp_test_NHBdhCepaAeqho',
            'amount': total * 100, //in paise.
            'name': 'MP Brand.',
            // 'order_id':
            //     'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
            'description': productData!['title'] ?? 'No description',
            'timeout': 60, // in seconds
            // 'prefill': {
            //   'contact': '9000090000',
            //   'email': 'gaurav.kumar@example.com'
            // }
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
