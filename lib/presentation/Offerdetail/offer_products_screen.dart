import 'package:flutter/material.dart';

class OfferProductsScreen extends StatelessWidget {
  final int offerIndex;

  OfferProductsScreen({required this.offerIndex});

  final List<List<Map<String, dynamic>>> offerProducts = [
    [
      {
        'name': 'Modern Chair',
        'image':
            'https://t3.ftcdn.net/jpg/01/20/36/84/360_F_120368458_jM1rSc1O5k58W6KM4aaexJnVpTaD768g.jpg',
        'price': 1299,
        'discountedPrice': 899,
        'offerEnds': '2 days left',
        'rating': 4,
      },
      {
        'name': 'Wooden Table',
        'image':
            'https://plus.unsplash.com/premium_photo-1675186049409-f9f8f60ebb5e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y2xvdGhpbmd8ZW58MHx8MHx8fDA%3D',
        'price': 2599,
        'discountedPrice': 1999,
        'offerEnds': '1 day left',
        'rating': 5,
      },
    ],
    [
      {
        'name': 'Night Lamp',
        'image':
            'https://images.unsplash.com/photo-1523199455310-87b16c0eed11?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fHNoaXJ0c3xlbnwwfHwwfHx8MA%3D%3D',
        'price': 799,
        'discountedPrice': 499,
        'offerEnds': 'Ends tonight',
        'rating': 3,
      },
      {
        'name': 'Luxury Sofa',
        'image':
            'https://t3.ftcdn.net/jpg/01/20/36/84/360_F_120368458_jM1rSc1O5k58W6KM4aaexJnVpTaD768g.jpg',
        'price': 5999,
        'discountedPrice': 4499,
        'offerEnds': '3 days left',
        'rating': 5,
      },
    ],
    [
      {
        'name': 'Smart Watch',
        'image':
            'https://plus.unsplash.com/premium_photo-1675186049409-f9f8f60ebb5e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y2xvdGhpbmd8ZW58MHx8MHx8fDA%3D',
        'price': 3499,
        'discountedPrice': 2999,
        'offerEnds': '4 hours left',
        'rating': 4,
      },
      {
        'name': 'Running Shoes',
        'image':
            'https://t3.ftcdn.net/jpg/01/20/36/84/360_F_120368458_jM1rSc1O5k58W6KM4aaexJnVpTaD768g.jpg',
        'price': 2299,
        'discountedPrice': 1599,
        'offerEnds': '1 day left',
        'rating': 4,
      },
    ],
    [
      {
        'name': 'Headphones',
        'image':
            'https://t3.ftcdn.net/jpg/01/20/36/84/360_F_120368458_jM1rSc1O5k58W6KM4aaexJnVpTaD768g.jpg',
        'price': 1599,
        'discountedPrice': 1199,
        'offerEnds': '2 days left',
        'rating': 4,
      },
      {
        'name': 'Mechanical Keyboard',
        'image':
            'https://t3.ftcdn.net/jpg/01/20/36/84/360_F_120368458_jM1rSc1O5k58W6KM4aaexJnVpTaD768g.jpg',
        'price': 2699,
        'discountedPrice': 1999,
        'offerEnds': '5 hours left',
        'rating': 5,
      },
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final products = offerProducts[offerIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Exclusive Offers'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.65, // 👈 Fixed here
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            final discountPercent =
                ((1 - (product['discountedPrice'] / product['price'])) * 100)
                    .round();

            return Container(
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
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(18)),
                    child: Image.network(
                      product['image'],
                      height: 130,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name'],
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
                              star < product['rating']
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
                              '₹${product['discountedPrice']}',
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '₹${product['price']}',
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
                          product['offerEnds'],
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
                                onPressed: () {
                                  // Handle buy
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('Buy Now'),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              Icons.delete_outline,
                              color: Colors.grey[600],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
