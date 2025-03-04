import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FilterProduct extends StatefulWidget {
  @override
  _FilterProductState createState() => _FilterProductState();
}

class _FilterProductState extends State<FilterProduct> {
  int selectedSizeIndex = 1; // Default selected index (e.g., "M")

  double _minPrice = 78;
  double _maxPrice = 143;
  List<String> sizes = ["XS", "S", "M", "L", "XL"];
  String selectedSize = "S";

  List<String> categories = ["All", "Women", "Men", "Boys", "Girls"];
  String selectedCategory = "All";

  List<Color> colors = [
    Colors.black,
    Colors.red,
    Colors.white,
    Colors.brown,
    Colors.blue
  ];
  Color selectedColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "Filters",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const Text("Price range",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$${_minPrice.toInt()}"),
                      Text("\$${_maxPrice.toInt()}"),
                    ],
                  ),
                  RangeSlider(
                    values: RangeValues(_minPrice, _maxPrice),
                    min: 50,
                    max: 200,
                    activeColor: Colors.red,
                    inactiveColor: Colors.grey.shade300,
                    onChanged: (RangeValues values) {
                      setState(() {
                        _minPrice = values.start;
                        _maxPrice = values.end;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  const Text("Colors",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: colors.map((color) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColor = color;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                            border: Border.all(
                              color: selectedColor == color
                                  ? Colors.red
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                  const Text("Sizes",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: sizes.map((size) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: selectedSize == size
                                ? Colors.red
                                : Colors.white,
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              color: selectedSize == size
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                  const Text("Category",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: categories.map((category) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: selectedCategory == category
                                ? Colors.red
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.red),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: selectedCategory == category
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // Fixed Bottom Buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey, blurRadius: 2),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black),
                    ),
                    onPressed: () {
                      Fluttertoast.showToast(msg: 'Discard filter');
                      Navigator.pop(context);
                    },
                    child: const Text("Discard",
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Fluttertoast.showToast(msg: 'Apply filter');
                      Navigator.pop(context);
                    },
                    child: const Text("Apply",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
