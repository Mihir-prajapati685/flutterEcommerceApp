import 'package:ecommerce_app/presentation/ProdutBuypage/editaddress.dart';
import 'package:flutter/material.dart';

class Addresschange extends StatefulWidget {
  @override
  State<Addresschange> createState() => _AddressChange();
}

class _AddressChange extends State<Addresschange> {
  int? selectedAddress; // Store selected address ID

  final List<Map<String, dynamic>> addresses = [
    {
      "id": 1,
      "name": "Janki Prajapati",
      "address":
          "54 Ayodhya Dham, Nani Kadi, near by Krishna Flat, Kadi, Gujarat - 382715",
      "phone": "7069737512"
    },
    {
      "id": 2,
      "name": "Mihit Prajapati",
      "address":
          "Ganpat University, Kherva Hostel H, Near Kherva Road, Mahesana District, Gujarat - 384012",
      "phone": "9316445389"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text("Select Address"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 2,
                    blurRadius: 2,
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  IconButton(
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditButtonpage()));
                    },
                    icon: Icon(Icons.add, size: 24),
                  ),
                  Text(
                    'Add a new Address',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final address = addresses[index];
                  return Card(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      children: [
                        RadioListTile<int>(
                          value: address["id"],
                          groupValue: selectedAddress,
                          onChanged: (value) {
                            setState(() {
                              selectedAddress = value;
                            });
                          },
                          title: Text(
                            address["name"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(address["address"]),
                              SizedBox(height: 5),
                              Text("📞 ${address["phone"]}"),
                            ],
                          ),
                        ),
                        if (selectedAddress ==
                            address[
                                "id"]) // Show Edit button only for selected address
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditButtonpage()));
                              },
                              child: Text(
                                "Edit",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "DELIVER HERE",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
