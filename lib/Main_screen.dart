import 'dart:convert';
import 'dart:ffi';
import 'package:ecommerce_app/onlyFunction/onbottomtab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ecommerce_app/homescreenwidget/grid_item_product.dart';
import 'package:ecommerce_app/homescreenwidget/icon_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

final fetchprovider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final data = await http.get(Uri.parse('https://fakestoreapi.com/products/'));
  if (data.statusCode == 200) {
    return List<Map<String, dynamic>>.from(jsonDecode(data.body));
  } else {
    throw Exception('failed data fetch');
  }
});

class MainScreenState extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, ref, child) {
            final productasync = ref.watch(fetchprovider);
            return Column(
              children: [
                //for photo
                Stack(
                  children: [
                    Container(
                      height: 500,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/splash.webp',
                        fit: BoxFit.cover,
                        colorBlendMode: BlendMode.multiply,
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Fashion\n',
                                  style: GoogleFonts.radioCanada(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Sale',
                                  style: GoogleFonts.radioCanada(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'click me',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'New',
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
                      productasync.when(
                        data:
                            (prodct) => SizedBox(
                              height: 450,
                              child: ListView.builder(
                                scrollDirection:
                                    Axis.horizontal, // ✅ Fix scrolling issue inside Column
                                // ✅ Prevent ListView from interfering with scrolling
                                itemCount: prodct.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 200,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey[100],
                                      boxShadow: [
                                        // ✅ Add shadow for better UI
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 5,
                                          spreadRadius: 2,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              child: Image.network(
                                                prodct[index]['image'],
                                                fit: BoxFit.cover,
                                              ),
                                              height: 300,
                                              color: Colors.red,
                                              width:
                                                  double
                                                      .infinity, // ✅ Corrected key
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                top: 7,
                                                left: 7,
                                              ),
                                              height: 25,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color: Colors.red[400],
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${prodct[index]['price']}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        RatingBarIndicator(
                                          rating:
                                              (prodct[index]['rating']['rate'])
                                                  .toDouble(),
                                          itemCount: 5,
                                          itemSize: 30,
                                          itemBuilder: (context, index) {
                                            return Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            );
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 3,
                                          ),
                                          child: Text(
                                            prodct[index]['title']
                                                    .split('')
                                                    .take(20)
                                                    .join('') +
                                                (prodct[index]['title']
                                                            .split('')
                                                            .length >
                                                        20
                                                    ? '...'
                                                    : ''),
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                              color: Colors.black87,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: Text(
                                            "\$${prodct[index]['price']}",
                                            style: GoogleFonts.robotoCondensed(
                                              color: Colors.red[400],
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ), // ✅ Corrected index usage
                                        // ✅ Show price
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                        error: (error, stack) => Text("Error: $error"),
                        loading: () => CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,  // ✅ Ensure all items are aligned properly
        selectedItemColor: Colors.red,       // ✅ Customize selected item color
        unselectedItemColor: Colors.grey,    // ✅ Customize unselected item color
        showSelectedLabels: true,            // ✅ Show labels always
        showUnselectedLabels: true,
        onTap: (index)=>onItemTapped(context, index),// ✅ Ensure unselected labels are also visible
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.shoppingBag),
            label: "Bag",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.cartPlus),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.userCircle),
            label: "User",
          ),
        ],
      ),

    );
  }
}
