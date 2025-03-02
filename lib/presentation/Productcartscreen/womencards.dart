import 'package:ecommerce_app/Data/ProductCardData/WomencardData.dart';
import 'package:ecommerce_app/Models/Product.dart';
import 'package:ecommerce_app/presentation/ProductDetail/productdetail.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Womencards extends StatelessWidget {
  final String categoryid;

  Womencards({required this.categoryid});
  @override
  Widget build(BuildContext context) {
    // List<Product> filteredProducts =
    //     products.where((product) => product.id == categoryid).toList();
    // if (filteredProducts.isEmpty) {
    //   Fluttertoast.showToast(msg: "no product");
    // }
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
                Text("Filters"),
                Spacer(),
                Icon(Icons.sort),
                SizedBox(width: 5),
                Text("Price: Lowest to High"),
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
                  return InkWell(
                    onTap: () {
                      final String img = filteredProducts[index].image;
                      final String name = filteredProducts[index].name;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                    img: img,
                                    name: name,
                                  )));
                    },
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
