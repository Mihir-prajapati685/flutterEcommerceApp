import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/presentation/ProductDetail/productdetail.dart';
import 'package:flutter/material.dart';

class OfferProductsScreen extends StatelessWidget {
  final int offerIndex;

  OfferProductsScreen({required this.offerIndex});

  final List<List<Map<String, dynamic>>> offerProducts = [
    [
      {
        'id': 'p001',
        'name': 'Modern Chair',
        'image':
            'https://t3.ftcdn.net/jpg/01/20/36/84/360_F_120368458_jM1rSc1O5k58W6KM4aaexJnVpTaD768g.jpg',
        'price': 1299,
        'discountedPrice': 899,
        'offerEnds': '2 days left',
        'rating': 4,
        'description': 'A stylish modern chair perfect for your living room.',
        'category': 'furniture',
      },
      {
        'id': 'p002',
        'name': 'Wooden Table',
        'image':
            'https://plus.unsplash.com/premium_photo-1675186049409-f9f8f60ebb5e?fm=jpg&q=60&w=3000',
        'price': 2599,
        'discountedPrice': 1999,
        'offerEnds': '1 day left',
        'rating': 5,
        'description': 'A solid wooden table that fits every modern home.',
        'category': 'furniture',
      },
    ],
    [
      {
        'id': 'p001',
        'name': 'Modern Chair',
        'image':
            'https://t3.ftcdn.net/jpg/01/20/36/84/360_F_120368458_jM1rSc1O5k58W6KM4aaexJnVpTaD768g.jpg',
        'price': 1299,
        'discountedPrice': 899,
        'offerEnds': '2 days left',
        'rating': 4,
        'description': 'A stylish modern chair perfect for your living room.',
        'category': 'furniture',
      },
      {
        'id': 'p002',
        'name': 'Wooden Table',
        'image':
            'https://plus.unsplash.com/premium_photo-1675186049409-f9f8f60ebb5e?fm=jpg&q=60&w=3000',
        'price': 2599,
        'discountedPrice': 1999,
        'offerEnds': '1 day left',
        'rating': 5,
        'description': 'A solid wooden table that fits every modern home.',
        'category': 'furniture',
      },
    ],
    [
      {
        'id': 'p001',
        'name': 'Modern Chair',
        'image':
            'https://t3.ftcdn.net/jpg/01/20/36/84/360_F_120368458_jM1rSc1O5k58W6KM4aaexJnVpTaD768g.jpg',
        'price': 1299,
        'discountedPrice': 899,
        'offerEnds': '2 days left',
        'rating': 4,
        'description': 'A stylish modern chair perfect for your living room.',
        'category': 'furniture',
      },
      {
        'id': 'p002',
        'name': 'Wooden Table',
        'image':
            'https://plus.unsplash.com/premium_photo-1675186049409-f9f8f60ebb5e?fm=jpg&q=60&w=3000',
        'price': 2599,
        'discountedPrice': 1999,
        'offerEnds': '1 day left',
        'rating': 5,
        'description': 'A solid wooden table that fits every modern home.',
        'category': 'furniture',
      },
    ],
    [
      {
        'id': 'p001',
        'name': 'Modern Chair',
        'image':
            'https://t3.ftcdn.net/jpg/01/20/36/84/360_F_120368458_jM1rSc1O5k58W6KM4aaexJnVpTaD768g.jpg',
        'price': 1299,
        'discountedPrice': 899,
        'offerEnds': '2 days left',
        'rating': 4,
        'description': 'A stylish modern chair perfect for your living room.',
        'category': 'furniture',
      },
      {
        'id': 'p002',
        'name': 'Wooden Table',
        'image':
            'https://plus.unsplash.com/premium_photo-1675186049409-f9f8f60ebb5e?fm=jpg&q=60&w=3000',
        'price': 2599,
        'discountedPrice': 1999,
        'offerEnds': '1 day left',
        'rating': 5,
        'description': 'A solid wooden table that fits every modern home.',
        'category': 'furniture',
      },
    ],
    // Add more offers with products (each with 2 products per offer)
  ];

  Future<void> addProductToFirebase(
      Map<String, dynamic> product, int offerIndex) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore
          .collection('productdetail')
          .doc(product['id'].toString())
          .set({
        'id': product['id'],
        'title': product['name'] ?? '',
        'image': product['image'] ?? '',
        'price': product['price'] ?? 0,
        'offerEnds': product['offerEnds'] ?? '',
        'rating': {
          'rate': product['rating'] ?? 0,
          'count': 50, // default count
        },
        'description': product['description'] ?? 'No description available.',
        'category': product['category'] ?? 'general',
      });

      print("✅ Product '${product['name']}' added to Firebase.");
    } catch (e) {
      print("❌ Failed to add product: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (offerIndex < 0 || offerIndex >= offerProducts.length) {
      return Scaffold(
        appBar: AppBar(title: Text('Invalid Offer')),
        body: Center(child: Text('No products available for this offer.')),
      );
    }
    final products = offerProducts[offerIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Exclusive Offers'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Offer Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://via.placeholder.com/600x200?text=Offer+Image',
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 16),
            // Product Grid for this Offer
            GridView.builder(
              shrinkWrap: true, // To avoid taking too much space
              physics:
                  NeverScrollableScrollPhysics(), // Disable scrolling for this GridView
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                final String imageUrl =
                    product['image'] ?? 'https://via.placeholder.com/150';
                final discountPercent =
                    ((1 - (product['discountedPrice'] / product['price'])) *
                            100)
                        .round();

                return GestureDetector(
                  onTap: () async {
                    await addProductToFirebase(product, offerIndex);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetail(productId: product['id'].toString()),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(18)),
                          child: Image.network(
                            imageUrl,
                            height: 130,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'] ?? 'No Name',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: List.generate(5, (star) {
                                  return Icon(
                                    star < (product['rating'] ?? 0)
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.orange,
                                    size: 16,
                                  );
                                }),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    '₹${product['discountedPrice'] ?? 0}',
                                    style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '₹${product['price'] ?? 0}',
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade100,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      '$discountPercent% OFF',
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 11),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                product['offerEnds'] ?? '',
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await addProductToFirebase(
                                            product, offerIndex);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductDetail(
                                                productId:
                                                    product['id'].toString()),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text(
                                        'Details',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
