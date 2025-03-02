import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenCategory extends StatelessWidget {
  MenCategory({super.key});
  final List<Map<String, String>> menCategories = [
    {
      "title": "Jeans",
      "image":
          "https://static.vecteezy.com/system/resources/thumbnails/040/220/078/small/ai-generated-men-s-jeans-close-up-of-a-man-s-hand-in-a-jeans-pocket-photo.jpg"
    },
    {
      "title": "Formal Wear",
      "image":
          "https://i.pinimg.com/474x/70/ae/10/70ae1024f1545e725d40e49f77aedf8c.jpg"
    },
    {
      "title": "Shorts",
      "image":
          "https://i.pinimg.com/736x/51/1e/5c/511e5c1d57af11f3b15242bb43c3560b.jpg"
    },
    {
      "title": "Shirts",
      "image":
          "https://img.freepik.com/free-photo/basic-green-shirt-men-rsquo-s-fashion-apparel-studio-shoot_53876-101197.jpg"
    },
    {
      "title": "Tshirts",
      "image": "https://veirdo.in/cdn/shop/files/vb200.jpg?v=1728462042"
    },
    {
      "title": "Jackets",
      "image":
          "https://img.freepik.com/free-photo/young-handsome-man-walking-down-street_1303-24594.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: menCategories.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: const Color.fromARGB(255, 243, 76, 64), width: 1),
                // boxShadow: [
                //   BoxShadow(
                //       color: Colors.grey, spreadRadius: 1, blurRadius: 3),
                // ]
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 5,
                    top: 50,
                    child: Text(
                      menCategories[index]['title']!,
                      style: GoogleFonts.b612(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        child: Container(
                          width: 185,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Image.network(
                            menCategories[index]["image"]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                ],
              ),
            );
          }),
    );
  }
}
