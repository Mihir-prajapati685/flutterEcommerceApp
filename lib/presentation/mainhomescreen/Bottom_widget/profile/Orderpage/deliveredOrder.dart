import 'package:flutter/material.dart';

class Deliveredorder extends StatefulWidget {
  @override
  State<Deliveredorder> createState() => _Deliveredorder();
}

class _Deliveredorder extends State<Deliveredorder> {
  final List<Map<String, String>> orders = [
    {
      "orderNumber": "№1947034",
      "tracking": "IW3475453455",
      "date": "05-12-2019",
      "quantity": "3",
      "totalAmount": "112\$",
      "status": "Delivered"
    },
    {
      "orderNumber": "№1947035",
      "tracking": "IW3475453456",
      "date": "06-12-2019",
      "quantity": "2",
      "totalAmount": "80\$",
      "status": "Delivered"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10), // Some spacing
          Expanded(
            // Ensures ListView takes the available space
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                var order = orders[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order ${order["orderNumber"]}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              order["date"]!,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Tracking number: ${order["tracking"]}",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Quantity: ${order["quantity"]}",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              "Total Amount: ${order["totalAmount"]}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                side: BorderSide(color: Colors.black),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text("Details",
                                  style: TextStyle(color: Colors.black)),
                            ),
                            Text(
                              order["status"]!,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
