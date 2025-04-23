import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/presentation/ProductDetail/productdetail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainscreenTopbrandItem extends StatefulWidget {
  const MainscreenTopbrandItem({super.key});
  @override
  State<MainscreenTopbrandItem> createState() => _MainscreenTopbrandItem();
}

class _MainscreenTopbrandItem extends State<MainscreenTopbrandItem> {
  List<Map<String, String>> stories = [];
  List<Map<String, String>> products = [];
  String selectedBrand = '';

  @override
  void initState() {
    super.initState();
    fetchBrandStories();
  }

  Future<void> fetchBrandStories() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('stories').get();

    final List<Map<String, String>> loadedStories =
        querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return {
        'image': data['image']?.toString() ?? '',
        'name': data['name']?.toString() ?? '',
      };
    }).toList();

    setState(() {
      stories = loadedStories;
      if (stories.isNotEmpty) {
        selectedBrand = stories[0]['name']!;
        fetchProductsForBrand(selectedBrand);
      }
    });
  }

  Future<void> fetchProductsForBrand(String brandName) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('brand', isEqualTo: brandName)
        .get();

    final List<Map<String, String>> loadedProducts =
        querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return {
        'id': doc.id,
        'image': data['image']?.toString() ?? '',
        'title': data['title']?.toString() ?? '',
        'price': data['price']?.toString() ?? '',
      };
    }).toList();

    setState(() {
      selectedBrand = brandName;
      products = loadedProducts;
    });
  }

  Future<void> handleProductClick(
      BuildContext context, String productId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get();

      if (doc.exists) {
        final data = doc.data();

        if (data != null) {
          final productData = {
            'productId': productId,
            'title': data['title']?.toString() ?? 'Untitled Product',
            'image': data['image']?.toString() ?? '',
            'price': data['price']?.toString() ?? '0',
            'description': data['description']?.toString() ?? 'No description',
            'category': data['category']?.toString() ?? 'Uncategorized',
            'brand': data['brand']?.toString() ?? 'Unknown',
            'timestamp': FieldValue.serverTimestamp(),
          };

          // Check if already exists
          final existing = await FirebaseFirestore.instance
              .collection('productDetails')
              .where('productId', isEqualTo: productId)
              .limit(1)
              .get();

          if (existing.docs.isEmpty) {
            await FirebaseFirestore.instance
                .collection('productDetails')
                .add(productData);
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetail(productId: productId),
            ),
          );
        } else {
          _showError(context, 'Product data is missing.');
        }
      } else {
        _showError(context, 'Product does not exist.');
      }
    } catch (e) {
      _showError(context, 'Something went wrong: $e');
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Top Brands',
            style: GoogleFonts.titilliumWeb(
              color: Colors.black87,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'View all',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ],
      ),
      SizedBox(height: 30),
      stories.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: stories.map((story) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          fetchProductsForBrand(story['name']!);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              story['image']!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error, color: Colors.red);
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        story['name']!,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
      Padding(
        padding: EdgeInsets.only(top: 20, left: 8.0, right: 8.0),
        child: products.isEmpty
            ? Text('No products available for $selectedBrand')
            : GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(
                    imageUrl: products[index]["image"]!,
                    title: products[index]["title"]!,
                    price: products[index]["price"]!,
                    productId: products[index]["id"]!,
                    onTap: () =>
                        handleProductClick(context, products[index]["id"]!),
                  );
                },
              ),
      ),
    ]);
  }
}

class ProductCard extends StatelessWidget {
  final String imageUrl, title, price, productId;
  final VoidCallback onTap;

  ProductCard({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.productId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 180,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 6),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(price, style: TextStyle(color: Colors.green, fontSize: 16)),
        ],
      ),
    );
  }
}
