import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final String img;
  final String name;

  ProductDetail({required this.img, required this.name});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int quantity = 1;
  List<String> imgurl = [
    "https://images.bewakoof.com/web/Blouson---Designer-girls-top-design---Bewakoof-Blog.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOtDN9v-U3McxsiaJmdmLj0rW7yA1RHDdh2iuxo9buipWtnJhO5q5Pfv_X9c5ZM7agXmY&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWy48dJqmmZ5mQaLfJ_OzedAisYj8GF_Nf7X-cTu27f8nIC7rDOGPDH4OY_pw2U5Xzm-s&usqp=CAU"
  ]; // State for quantity selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 500, // Image height
            floating: false,
            pinned: true,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.share,
                  size: 20,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.img, // Change with your product image
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),

                  // Price
                  Text(
                    "\$ ${60.00 * quantity}",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),

                  // SKU & Availability
                  Row(
                    children: [
                      Text(
                        "SKU: INS16-1",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Availability: In stock (999405)",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Description
                  Container(
                    width: double.infinity,
                    height: 30,
                    color: const Color.fromARGB(255, 228, 246, 255),
                    child: Text(
                      "Modern T-shirt design",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Size Selector
                  Text(
                    "Size",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: ["L", "M", "S", "XL"]
                        .map((size) => Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: ChoiceChip(
                                label: Text(size),
                                selected: size == "XL", // Example selection
                                selectedColor: Colors.red,
                                backgroundColor: Colors.white,
                                labelStyle: TextStyle(
                                    color: size == "XL"
                                        ? Colors.white
                                        : Colors.black),
                                onSelected: (selected) {},
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 20),

                  // Color Options
                  Text(
                    "Color",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      _colorOption(imgurl[0]),
                      _colorOption(imgurl[1]),
                      _colorOption(imgurl[2]),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Quantity Selector
                  Text(
                    "Select the quantity:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      _quantityButton(Icons.remove, () {
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      }),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "$quantity",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      _quantityButton(Icons.add, () {
                        setState(() {
                          quantity++;
                        });
                      }),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            "Buy Now",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(color: Colors.red),
                          ),
                          child: Text(
                            "ADD TO CART",
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Description Section
                  ExpansionTile(
                    title: Text(
                      "DESCRIPTION",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _descriptionItem("Soft-touch jersey"),
                            _descriptionItem("Crew neck"),
                            _descriptionItem("Chest print"),
                            _descriptionItem("Regular fit - true to size"),
                            _descriptionItem("Machine wash"),
                            _descriptionItem("60% Cotton, 40% Polyester"),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ExpansionTile(
                    title: Text(
                      "ADDITIONAL INFORMATION",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            __extraInformation("Size", "L,M,s,XL"),
                            SizedBox(
                              height: 20,
                            ),
                            __extraInformation("Image", "black,blue,red"),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for color options
  Widget _colorOption(String imageUrl) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Widget for quantity buttons
  Widget _quantityButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.red),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.red),
        onPressed: onPressed,
      ),
    );
  }

  // Description item
  Widget _descriptionItem(String text) {
    return Row(
      children: [
        Icon(Icons.check, color: Colors.red, size: 18),
        SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget __extraInformation(String text, String tex1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 17),
        ),
        SizedBox(
          width: 50,
        ),
        Text(
          tex1,
          style: TextStyle(fontSize: 17),
        )
      ],
    );
  }
}
