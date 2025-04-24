import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentLastPage extends StatefulWidget {
  State<PaymentLastPage> createState() => _PaymentLastPage();
}

class _PaymentLastPage extends State<PaymentLastPage> {
  @override
  void dispose() {
    _razorpay.clear();
  }

  void initState() {
    super.initState();
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

  var _razorpay = Razorpay();
  String? selectedBank;
  String? selectedupi;
  TextEditingController phonecontroller = TextEditingController(
      text: "9316445389"); // Net Banking ke selected bank ka naam store karega

  List<String> banks = [
    "HDFC Bank",
    "ICICI Bank",
    "State Bank of India",
    "Axis Bank",
    "Kotak Mahindra Bank"
  ];
  List<String> forupi = [
    "Google Pay",
    "Phone Pay",
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payments"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Amount", style: TextStyle(fontSize: 16)),
                    Text("₹199",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildPaymentOption("Flipkart UPI", Icons.payment, Colors.blue),
              _buildPaymentOption(
                "Credit / Debit / ATM Card",
                Icons.credit_card,
              ),
              _buildPaymentOption("Net Banking", Icons.account_balance),
              _buildPaymentOption("Wallets", Icons.account_balance_wallet),
              _buildPaymentOption("UPI", Icons.payment),
              _buildPaymentOption("Cash on Delivery", Icons.money),
              _buildPaymentOption(
                  "Have a Flipkart Gift Card?", Icons.card_giftcard),
              SizedBox(height: 20),
              Center(
                  child: Text("35 Crore happy customers and counting!",
                      style: TextStyle(fontSize: 14))),
              SizedBox(height: 10),
              Center(child: Icon(Icons.emoji_emotions_outlined, size: 30)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
    String title, [
    IconData icon = Icons.payment,
    Color? color,
    bool isNew = false,
    bool isLink = false,
  ]) {
    return Column(
      children: [
        // ListTile(
        //   leading: Icon(Icons.payment, color: color ?? Colors.black),
        //   title: Row(
        //     children: [
        //       Text(title),
        //       if (isNew)
        //         Padding(
        //           padding: const EdgeInsets.only(left: 5),
        //           child: Container(
        //             padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        //             decoration: BoxDecoration(
        //                 color: Colors.red,
        //                 borderRadius: BorderRadius.circular(4)),
        //             child: Text("New",
        //                 style: TextStyle(color: Colors.white, fontSize: 12)),
        //           ),
        //         ),
        //     ],
        //   ),
        //   trailing: isLink
        //       ? Text("Add", style: TextStyle(color: Colors.blue))
        //       : Icon(Icons.keyboard_arrow_down),
        // ),
        // Divider(),
        ExpansionTile(
          leading: Icon(
            icon,
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title == "Net Banking"
                      ? _netbanking(banks, selectedBank, (value) {
                          setState(() {
                            selectedBank = value;
                          });
                        })
                      : SizedBox(),
                  title == "Cash on Delivery" ? _cashondelivery() : SizedBox(),
                  title == "UPI"
                      ? _upi(forupi, selectedupi, (value) {
                          setState(() {
                            selectedupi = value;
                          });
                        })
                      : SizedBox(),
                  title == "Wallets" ? _wallet(phonecontroller) : SizedBox(),
                  title == "Credit / Debit / ATM Card"
                      ? _creditcard()
                      : SizedBox()
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildDisabledOption(String title, String subtitle) {
    return ListTile(
      leading: Icon(Icons.block, color: Colors.grey),
      title: Text(title, style: TextStyle(color: Colors.grey)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
    );
  }

  Widget _netbanking(
      List<String> banks, String? selectedBank, Function(String?) onChanged) {
    return Column(
      children: [
        Column(
          children: banks.map((bank) {
            return RadioListTile<String>(
              title: Text(bank),
              value: bank,
              groupValue: selectedBank,
              onChanged: onChanged,
            );
          }).toList(),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            // Payment logic here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
          child: Text(
            "Pay ₹25 advance",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
  //  Widget _wallets(){
  //   return

  // }
  Widget _upi(
      List<String> forupi, String? selectedupi, Function(String?) onChanged) {
    return Column(children: [
      Column(
        children: forupi.map((forupi) {
          return RadioListTile<String>(
            title: Text(forupi),
            value: forupi,
            groupValue: selectedupi,
            onChanged: onChanged,
          );
        }).toList(),
      ),
      ElevatedButton(
        onPressed: () {
          // Payment logic here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
        child: Text(
          "Pay ₹25 advance",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    ]);
  }

  Widget _cashondelivery() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pay ₹25 using any online payment option and pay the balance amount of ₹174 as cash during delivery",
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              // Payment logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
            child: Text(
              "Pay ₹25 advance",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _wallet(TextEditingController phoneController) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Wallet Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Radio(
                    value: "PhonePe",
                    groupValue: "PhonePe",
                    onChanged: (value) {},
                    activeColor: Colors.blue,
                  ),
                  Text(
                    "PhonePe Wallet",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Icon(Icons.account_balance_wallet, color: Colors.purple),
            ],
          ),

          SizedBox(height: 10),

          Text("PhonePe linked mobile number",
              style: TextStyle(color: Colors.grey)),

          SizedBox(height: 5),

          // Mobile Number Input
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
          ),

          SizedBox(height: 10),

          // Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Link phone number logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text("Link"),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Payment logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                  ),
                  child: Text("Pay ₹199"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _creditcard() {
    return Column(
      children: [
        SizedBox(height: 12),
        // Card Number Input
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Card Number",
            hintText: "XXXX XXXX XXXX XXXX",
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.credit_card),
          ),
        ),
        SizedBox(height: 12),

        Row(
          children: [
            // Expiry Date Input
            Expanded(
              child: TextField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: "Valid Thru",
                  hintText: "MM / YY",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 10),

            // CVV Input
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "CVV",
                  hintText: "CVV",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.info_outline),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            // Payment logic here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
          child: Text(
            "Pay ₹25 advance",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
