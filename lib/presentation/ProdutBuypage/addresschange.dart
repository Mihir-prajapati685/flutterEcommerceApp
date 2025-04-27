import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/presentation/ProdutBuypage/editaddress.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Addresschange extends StatefulWidget {
  @override
  State<Addresschange> createState() => _AddressChange();
}

class _AddressChange extends State<Addresschange> {
  String?
      selectedAddress; // Change to String to match the ID type from Firestore
  List<Map<String, dynamic>> addresses = []; // Store addresses from Firestore
  bool isChecked = false; // Checkbox value to track if the checkbox is selected

  @override
  void initState() {
    super.initState();
    _fetchAddresses();
  }

  // Function to fetch addresses from Firestore
  Future<void> _fetchAddresses() async {
    try {
      // Get the current user's UID
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print("No user is logged in");
        return;
      }

      String userId = currentUser.uid;
      print("Fetching addresses for user UID: $userId");

      // Fetch the addresses for the current user from the "newaddress" collection
      final snapshot = await FirebaseFirestore.instance
          .collection('newaddress')
          .where('uid', isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> fetchedAddresses = snapshot.docs.map((doc) {
          return {
            'id': doc.id, // Firestore document ID, which is a String
            'fullName': doc['fullName'],
            'address': doc['house'] +
                ', ' +
                doc['road'] +
                ', ' +
                doc['city'] +
                ', ' +
                doc['state'] +
                ' - ' +
                doc['pincode'],
            'phoneNumber': doc['phoneNumber'],
          };
        }).toList();

        setState(() {
          addresses = fetchedAddresses;
        });
      } else {
        print("No addresses found for this user");
      }
    } catch (e) {
      print("Error fetching addresses: $e");
    }
  }

  // Function to store selected address to finaladdress collection
  Future<void> _storeFinalAddress(String addressId) async {
    try {
      // Get the current user's UID
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print("No user is logged in");
        return;
      }

      String userId = currentUser.uid;

      // Get the selected address data
      final selectedAddressData =
          addresses.firstWhere((address) => address['id'] == addressId);

      // Add the selected address to finaladdress collection
      await FirebaseFirestore.instance.collection('finaladdress').add({
        'uid': userId,
        'fullName': selectedAddressData['fullName'],
        'address': selectedAddressData['address'],
        'phoneNumber': selectedAddressData['phoneNumber'],
        'house': selectedAddressData['address'].split(
            ',')[0], // You can extract the specific address fields if necessary
        'road': selectedAddressData['address'].split(',')[1],
        'city': selectedAddressData['address'].split(',')[2],
        'state': selectedAddressData['address'].split(',')[3],
        'pincode': selectedAddressData['address'].split('-')[1].trim(),
      });

      print("Address stored in finaladdress collection successfully");
    } catch (e) {
      print("Error storing address: $e");
    }
  }

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
                        RadioListTile<String>(
                          value: address["id"],
                          groupValue: selectedAddress,
                          onChanged: (value) {
                            setState(() {
                              selectedAddress = value;
                            });
                          },
                          title: Text(
                            address["fullName"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(address["address"]),
                              SizedBox(height: 5),
                              Text("📞 ${address["phoneNumber"]}"),
                            ],
                          ),
                        ),
                        if (selectedAddress == address["id"])
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
                  if (selectedAddress != null) {
                    // Store the selected address in finaladdress collection
                    _storeFinalAddress(selectedAddress!);
                    Navigator.pop(context);
                  } else {
                    // Show a message if no address is selected
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please select an address")));
                  }
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
