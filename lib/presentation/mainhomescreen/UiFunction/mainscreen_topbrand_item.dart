import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainscreenTopbrandItem extends StatefulWidget {
  const MainscreenTopbrandItem({super.key});
  @override
  State<MainscreenTopbrandItem> createState() => _MainscreenTopbrandItem();
}

class _MainscreenTopbrandItem extends State<MainscreenTopbrandItem> {
  final List<Map<String, String>> stories = [
    {
      'image':
          'https://rukminim2.flixcart.com/image/850/1000/xif0q/jacket/t/c/z/l-1-no-jakt-denimslvless-mblue-urbano-fashion-original-imah6s9nevezgxvz.jpeg?q=90&crop=false',
      'name': 'Diesel'
    },
    {
      'image':
          'https://www.jiomart.com/images/product/original/rvcspdzjaf/forgive-boot-cut-style-men-s-boys-denim-jeans-perfect-for-casual-wear-mid-blue-30-product-images-rvcspdzjaf-1-202212010814.jpg?im=Resize=(500,630)',
      'name': 'Denim'
    },
    {
      'image':
          'https://i.pinimg.com/736x/c0/6e/2c/c06e2c9cecc4efaf87f00b66a251247d.jpg',
      'name': 'Gucci'
    },
    {
      'image':
          'https://www.garderobeitaly.com/wp-content/uploads/2023/03/IMG_3697.jpg',
      'name': 'Prada'
    },
    {
      'image':
          'https://www.azureofficial.pk/cdn/shop/files/Garnet-Majesty-_4_1024x1024.jpg?v=1731408849',
      'name': 'Azure'
    },
  ];
  final List<Map<String, String>> products = [
    {
      "image":
          "https://www.azureofficial.pk/cdn/shop/files/Garnet-Majesty-_4_1024x1024.jpg?v=1731408849",
      "title": "Human Face Print Casual",
      "price": "\$55.90"
    },
    {
      "image":
          "https://www.garderobeitaly.com/wp-content/uploads/2023/03/IMG_3697.jpg",
      "title": "Rainbow Floral Print Belted",
      "price": "\$55.90"
    },
    {
      "image":
          "https://i.pinimg.com/736x/c0/6e/2c/c06e2c9cecc4efaf87f00b66a251247d.jpg",
      "title": "Floral Print Puff Sleeve Midi",
      "price": "\$55.90"
    },
    {
      "image":
          "https://www.jiomart.com/images/product/original/rvcspdzjaf/forgive-boot-cut-style-men-s-boys-denim-jeans-perfect-for-casual-wear-mid-blue-30-product-images-rvcspdzjaf-1-202212010814.jpg?im=Resize=(500,630)",
      "title": "Solid V Neck Vacation Dress",
      "price": "\$55.90"
    },
  ];

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
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: stories.map((story) {
            return Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.black,
                          width: 1), // Instagram-like border
                    ),
                    child: ClipOval(
                      child: Image.network(
                        story['image']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  story['name']!,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            );
          }).toList(),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 20, left: 8.0, right: 8.0),
        child: GridView.builder(
          shrinkWrap: true, // Important to prevent layout issues
          physics: NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two items per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7, // Adjust for height
          ),
          itemBuilder: (context, index) {
            return ProductCard(
              imageUrl: products[index]["image"]!,
              title: products[index]["title"]!,
              price: products[index]["price"]!,
            );
          },
        ),
      ),
    ]);
  }
}

class ProductCard extends StatelessWidget {
  final String imageUrl, title, price;
  ProductCard(
      {required this.imageUrl, required this.title, required this.price});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(imageUrl,
                fit: BoxFit.cover, height: 180, width: double.infinity),
          ),
          SizedBox(height: 6),
          Text(title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(price, style: TextStyle(color: Colors.green, fontSize: 16)),
        ],
      ),
    );
  }
}
