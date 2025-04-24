import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Data/ProductCardData/WomencardData.dart';
import 'package:ecommerce_app/Models/Product.dart';
import 'package:ecommerce_app/presentation/ProductDetail/productdetail.dart';
import 'package:ecommerce_app/presentation/Productcartscreen/filterproduct.dart';
import 'package:ecommerce_app/presentation/Productcartscreen/sortedproduct.dart';
import 'package:flutter/material.dart';

class Womencards extends StatelessWidget {
  final String categoryid;

  Womencards({required this.categoryid});
  @override
  Future<void> addToProductDetailAndNavigate(
      BuildContext context, Product product) async {
    try {
      // Optional: Print for debugging
      print('Adding to Firestore:');
      print('id: ${product.id}');
      print('title: ${product.name}');
      print('image: ${product.image}');
      print('category: ${product.categoryId}');
      print('description: ${product.description}');
      print('price:${product.price}');

      if (product.id == null ||
          product.name == null ||
          product.image == null ||
          product.categoryId == null ||
          product.description == null ||
          product.price == null) {
        throw Exception('One or more product fields are null!');
      }

      await FirebaseFirestore.instance
          .collection('productdetail')
          .doc(product.id)
          .set({
        'id': product.id,
        'title': product.name,
        'image': product.image,
        'category': product.categoryId,
        'description': product.description,
        'price': product.price,
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetail(productId: product.id),
        ),
      );
    } catch (e) {
      print('Error in addToProductDetailAndNavigate: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong: $e")),
      );
    }
  }

  Widget build(BuildContext context) {
    List<Product> filteredProducts = products.toList();
    if (filteredProducts.isEmpty) {
      return Center(child: Text("No products found"));
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Women's Tops",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ["T-shirts", "Crop tops", "Blouses", "Shirts"]
                    .map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Chip(
                      label: Text(
                        category,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.black,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Filters & Sorting
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Icon(Icons.filter_list),
                SizedBox(width: 5),
                InkWell(
                  child: Text("Filters"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FilterProduct()));
                  },
                ),
                Spacer(),
                Icon(Icons.sort),
                SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    showFilterBottomSheet(context);
                  },
                  child: Text("Price: Lowest to High"),
                )
              ],
            ),
          ),

          // Empty Product Grid Placeholder
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                itemCount:
                    filteredProducts.length, // Example count, change as needed
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return InkWell(
                    onTap: () =>
                        addToProductDetailAndNavigate(context, product),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10)),
                                child: Image.network(
                                  filteredProducts[index]
                                      .image, // Placeholder Image
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Icon(Icons.favorite_border,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(filteredProducts[index].name,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12)),
                                SizedBox(height: 5),
                                Text("Product Name",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: 5),
                                Row(
                                  children: List.generate(5, (i) {
                                    return Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    );
                                  }),
                                ),
                                SizedBox(height: 5),
                                Text("\$50",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
