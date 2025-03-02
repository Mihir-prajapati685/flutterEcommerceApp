import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KidsCategory extends StatelessWidget {
  KidsCategory({super.key});
  final List<Map<String, String>> menCategories = [
    {
      "title": "Jeans",
      "image":
          "https://i.pinimg.com/736x/12/fb/47/12fb4767d3b14314bfc4baa09afee989.jpg"
    },
    {
      "title": "Formal Wear",
      "image":
          "https://s.alicdn.com/@sc04/kf/Hf860ed18d65443549cf914f70f5bad46C.jpg"
    },
    {
      "title": "Shorts",
      "image":
          "https://i.pinimg.com/originals/2e/a9/12/2ea91290a88088800d63c4cde8ce3e83.jpg"
    },
    {
      "title": "Shirts",
      "image":
          "https://5.imimg.com/data5/DW/WX/MY-35841556/boys-printed-shirt-500x500.jpg"
    },
    {
      "title": "Tshirts",
      "image":
          "https://static.vecteezy.com/system/resources/thumbnails/033/333/280/small/cute-sibling-or-friend-boy-and-girl-wearing-blank-empty-black-tshirt-mockup-for-design-template-ai-generated-free-photo.jpg"
    },
    {
      "title": "Jackets",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-p4z53OeW8WUwNobOaIq7v4YHuBCRi-3uoA&s"
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
