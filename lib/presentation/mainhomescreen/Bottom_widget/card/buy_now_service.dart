import 'package:ecommerce_app/presentation/ProdutBuypage/oredersummary.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuyNowService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> storeProductToBuyCollection(
      BuildContext context, Map<String, dynamic> productData) async {
    try {
      DocumentReference documentReference =
          await _firestore.collection('buy').add(productData);
      print("Added with ID: ${documentReference.id}");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Oredersummary(
              documentId: documentReference.id), // or any screen you want
        ),
      );
    } catch (e) {
      print("Error adding to buy collection: $e");
    }
  }
}
