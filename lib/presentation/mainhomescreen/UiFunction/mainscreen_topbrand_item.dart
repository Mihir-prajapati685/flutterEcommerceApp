import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainscreenTopbrandItem extends StatefulWidget {
  const MainscreenTopbrandItem({super.key});
  @override
  State<MainscreenTopbrandItem> createState() => _MainscreenTopbrandItem();
}

class _MainscreenTopbrandItem extends State<MainscreenTopbrandItem> {
  final int _hoveredIndex = -1;
  bool isJensSelected = true; // Track which category is selected

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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

        // Category Buttons (Jens / Ladies)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCategoryButton("Jens", isJensSelected),
            _buildCategoryButton("Ladies", !isJensSelected),
          ],
        ),
        // Image Grid
        isJensSelected
            ? _imgGensCategory(_hoveredIndex)
            : _imgladiesCategory(_hoveredIndex),
      ],
    );
  }

  Widget _buildCategoryButton(String text, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          isJensSelected = (text == "Jens");
        });
      },
      child: Container(
        height: 50,
        width: 170,
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.red
              : const Color.fromARGB(255, 245, 243, 243),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.crimsonPro(
              color: isSelected
                  ? Colors.white
                  : Colors.black, // Ensure text is visible
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }

  Widget _imgGensCategory(hoveredIndex) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        spacing: 20,
        runSpacing: 20,
        children: List.generate(6, (index) {
          return InkWell(
            onTap: () {
              setState(() {
                hoveredIndex = (hoveredIndex == index) ? -1 : index;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    height: 250,
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpE4L7KMYYwwJ2MIZQwm3U8j2_FyLMZEgx0w&s",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Animated White Overlay with Brand Name
                AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: hoveredIndex == index ? 1.0 : 0.0,
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Brand ${index + 1}",
                      style: GoogleFonts.titilliumWeb(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _imgladiesCategory(hoveredIndex) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        spacing: 20,
        runSpacing: 20,
        children: List.generate(6, (index) {
          return InkWell(
            onTap: () {
              setState(() {
                hoveredIndex = (hoveredIndex == index) ? -1 : index;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    height: 250,
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpE4L7KMYYwwJ2MIZQwm3U8j2_FyLMZEgx0w&s",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Animated White Overlay with Brand Name
                AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: hoveredIndex == index ? 1.0 : 0.0,
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Brand ${index + 1}",
                      style: GoogleFonts.titilliumWeb(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
