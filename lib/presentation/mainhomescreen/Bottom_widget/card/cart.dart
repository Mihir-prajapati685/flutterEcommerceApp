import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/card/bloc/cart_bloc.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/card/buy_now_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _Cart();
}

class _Cart extends State<Cart> {
  List<int> quantities = [];
  final CartBloc cartBloc = CartBloc();
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    cartBloc.add(CarPageInitialEvent());
  }

  // Update cart data when quantity changes
  void updateItemQuantity(List<dynamic> cartData, int index, int newQuantity) {
    setState(() {
      // Ensure quantity doesn't go below 1
      quantities[index] = newQuantity > 0 ? newQuantity : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          "My cart",
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
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    BlocConsumer<CartBloc, CartState>(
                      bloc: cartBloc,
                      listener: (context, state) {
                        if (state is CartFetchdataErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Data fetch error")));
                        } else if (state is ProductDeleteSucessState) {
                          Fluttertoast.showToast(
                              msg: "Product Delete Successfully");
                        } else if (state is ProdutDeleteErrorState) {
                          Fluttertoast.showToast(msg: "Product Delete Error");
                        } else if (state is ProductDeleteErrorState) {
                          Fluttertoast.showToast(
                              msg: "Product Delete nai thay ");
                        }
                      },
                      builder: (context, state) {
                        if (state is FirebasedatabaseEmptyState) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    'https://img.freepik.com/premium-vector/empty-cart_701961-7086.jpg',
                                    height: 300,
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Whoops',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Your cart is Empty',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Looks like your cart is empty, add something and make me happy',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'Shop Now',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (state is CartdataFetchSucessfullState) {
                          if (quantities.length != state.cartdata.length) {
                            quantities =
                                List<int>.filled(state.cartdata.length, 1);
                          }
                          return Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: state.cartdata.length,
                                itemBuilder: (context, index) {
                                  final item = state.cartdata[index];
                                  final String name =
                                      (item['title'] ?? 'No name').toString();
                                  final String imageUrl =
                                      (item['image'] ?? '').toString();
                                  final String price =
                                      (item['price'] ?? '0').toString();
                                  final double basePrice =
                                      double.tryParse(price) ?? 0.0;
                                  final String size = (item['selectedSize'] ??
                                          'size not selected')
                                      .toString();
                                  final String color = (item['selectedColor'] ??
                                          'size not selected')
                                      .toString();
                                  final String id =
                                      (item['id'] ?? 'no id').toString();

                                  return Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 5,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    imageUrl.isNotEmpty
                                                        ? imageUrl
                                                        : 'https://via.placeholder.com/150',
                                                    width: 120,
                                                    height: 120,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(width: 15),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        name,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      SizedBox(height: 8),
                                                      // Updated price calculation
                                                      Text(
                                                        "₹${(basePrice * quantities[index]).toStringAsFixed(2)}", // Dynamic price calculation
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.orange,
                                                        ),
                                                      ),
                                                      RatingBarIndicator(
                                                        rating: 4.5,
                                                        itemBuilder:
                                                            (context, index) =>
                                                                Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        itemCount: 5,
                                                        itemSize: 20.0,
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text("Size : ${size}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey)),
                                                      SizedBox(height: 5),
                                                      Text("Color : ${color}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey)),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 40,
                                                            width: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                            child: IconButton(
                                                              icon: Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 20),
                                                              onPressed: () {
                                                                // Decrease quantity but not below 1
                                                                if (quantities[
                                                                        index] >
                                                                    1) {
                                                                  updateItemQuantity(
                                                                      state
                                                                          .cartdata,
                                                                      index,
                                                                      quantities[
                                                                              index] -
                                                                          1);
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            "${quantities[index]}",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Container(
                                                            height: 40,
                                                            width: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                            child: IconButton(
                                                              icon: Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 20),
                                                              onPressed: () {
                                                                updateItemQuantity(
                                                                    state
                                                                        .cartdata,
                                                                    index,
                                                                    quantities[
                                                                            index] +
                                                                        1);
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.white,
                                                          side:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .red),
                                                          minimumSize:
                                                              Size(170, 45),
                                                        ),
                                                        onPressed: () async {
                                                          final productData = {
                                                            'title':
                                                                item['title'],
                                                            'price': basePrice *
                                                                quantities[
                                                                    index], // Send updated price
                                                            'image':
                                                                item['image'],
                                                            'selectedSize': item[
                                                                'selectedSize'],
                                                            'selectedColor': item[
                                                                'selectedColor'],
                                                            'quantity': quantities[
                                                                index], // Send updated quantity
                                                            'timestamp':
                                                                Timestamp.now()
                                                          };

                                                          await BuyNowService()
                                                              .storeProductToBuyCollection(
                                                                  context,
                                                                  productData);
                                                        },
                                                        child: const Text(
                                                            "Buy now",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 17)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: 5,
                                            top: 5,
                                            child: IconButton(
                                              icon: Icon(Icons.close,
                                                  color: Colors.red),
                                              onPressed: () {
                                                cartBloc.add(
                                                    ClickedRemoveProductEvent(
                                                        id));
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
