import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to store selected product to Firestore
  Future<void> storeSelectedProduct(Map<String, dynamic> product) async {
    try {
      // Store product data under a collection named "selected_product"
      await _firestore.collection('selected_product').doc('latest').set({
        'image': product['image'],
        'title': product['title'],
        'price': product['price'],
        'rating': product['rating']['rate'],
        'id': product['id'],
      });
      print("Product data stored successfully!");
    } catch (e) {
      print("Error storing product data: $e");
    }
  }
}
