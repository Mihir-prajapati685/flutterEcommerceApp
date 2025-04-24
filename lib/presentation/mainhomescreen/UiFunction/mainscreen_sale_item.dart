import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/presentation/ProductDetail/productdetail.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/bloc/mainscreen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http; // Import for RatingBarIndicator

class MainscreenSaleItem extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> _storeProductInFirestore(Map<String, dynamic> product) async {
    try {
      final docRef = await _firestore.collection('productdetail').add(product);
      final productId = docRef.id;
      print("Added successfully: $productId");
      return productId;
    } catch (e) {
      print("Error storing product in Firestore: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sale',
              style: GoogleFonts.titilliumWeb(
                color: Colors.black87,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        BlocProvider(
          create: (context) {
            final newbloc = MainscreenBloc(client: http.Client());
            newbloc.add(MainScreenInitialEvent());
            return newbloc;
          },
          child: BlocBuilder<MainscreenBloc, MainscreenState>(
            builder: (context, state) {
              if (state is MainScreenLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is MainScreenLoadedSuccessfullyState) {
                return SizedBox(
                  height: 450,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.product.length,
                    itemBuilder: (context, index) {
                      final product = state.product[index];
                      return Container(
                        width: 200,
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[100],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () async {
                                final productId =
                                    await _storeProductInFirestore(product);
                                if (productId != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetail(
                                        productId: productId,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: 300,
                                    width: double.infinity,
                                    child: Image.network(
                                      product['image'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 7,
                                    left: 7,
                                    child: Container(
                                      height: 25,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Center(
                                        child: Text(
                                          (product['rating']['count'])
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RatingBarIndicator(
                              rating: (product['rating']['rate']).toDouble(),
                              itemCount: 5,
                              itemSize: 30,
                              itemBuilder: (context, _) =>
                                  Icon(Icons.star, color: Colors.amber),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 3,
                              ),
                              child: Text(
                                product['title'].length > 20
                                    ? product['title'].substring(0, 20) + '...'
                                    : product['title'],
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                "\$${product['price']}",
                                style: GoogleFonts.robotoCondensed(
                                  color: Colors.red[400],
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else if (state is MainScreenErrorState) {
                return Center(child: Text('Error:${state.message}'));
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
