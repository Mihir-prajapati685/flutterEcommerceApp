import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetail extends StatefulWidget {
  final String productId;

  const ProductDetail({required this.productId});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Map<String, dynamic>? productData;
  String selectedSize = "Size";
  String selectedColor = "Black";
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    fetchProductData();
  }

  Future<void> fetchProductData() async {
    print("Fetching product with ID: ${widget.productId}");
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('productdetail')
          .doc(widget.productId)
          .get();
      print(documentSnapshot.data());

      if (documentSnapshot.exists) {
        setState(() {
          productData = documentSnapshot.data() as Map<String, dynamic>;
        });
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching product: $e');
    }
  }

  Future<void> addToFavourites() async {
    try {
      await FirebaseFirestore.instance
          .collection('favourite')
          .doc(widget.productId)
          .set(productData!);
      print("Product added to favourites");
      Fluttertoast.showToast(msg: "add successfully Favourites");
    } catch (e) {
      print("Error adding to favourites: $e");
    }
  }

  Future<void> addTocartdata() async {
    if (selectedSize == "Size") {
      Fluttertoast.showToast(
          msg: "Please select a size before adding to cart.");
      return;
    }

    try {
      final cartData = {
        ...productData!,
        'selectedSize': selectedSize,
        'selectedColor': selectedColor,
        'id': productData!['id'].toString(),
        'addedAt': Timestamp.now(), // optional: to track when it was added
      };

      await FirebaseFirestore.instance
          .collection('addtocart')
          .doc(widget.productId)
          .set(cartData);

      print("Product added to cart");
      Fluttertoast.showToast(msg: "Product successfully added to cart");
    } catch (e) {
      print("Error adding to cart: $e");
      Fluttertoast.showToast(msg: "Error adding to cart");
    }
  }

  void _showSizeModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select size',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                children: ['XS', 'S', 'M', 'L', 'XL'].map((size) {
                  final isSelected = selectedSize == size;
                  return ChoiceChip(
                    label: Text(size),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        selectedSize = size;
                      });
                      Navigator.pop(context);
                    },
                    selectedColor: Colors.deepPurple,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _showColorModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select color',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                children: ['Black', 'Red', 'Blue', 'Green'].map((color) {
                  final isSelected = selectedColor == color;
                  return ChoiceChip(
                    label: Text(color),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        selectedColor = color;
                      });
                      Navigator.pop(context);
                    },
                    selectedColor: Colors.deepPurple,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRatingStars(int count) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < count ? Icons.star : Icons.star_border,
          color: Colors.orange,
          size: 18,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
                if (isFavorite && productData != null) {
                  addToFavourites();
                }
              });
            },
            icon: Icon(
              Icons.favorite,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          )
        ],
      ),
      body: productData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(productData!['image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    productData!['title'],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Short black dress",
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildRatingStars(4),
                      const SizedBox(width: 8),
                      const Text("(10)"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _showSizeModal,
                          child: Text(selectedSize),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _showColorModal,
                          child: Text(selectedColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "₹${productData!['price']}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    productData!['description'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      addTocartdata();
                    },
                    child: const Center(
                      child: Text(
                        "ADD TO CART",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
