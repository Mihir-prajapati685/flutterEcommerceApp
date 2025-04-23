import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/card/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _Cart();
}

class _Cart extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    cartBloc.add(CarPageInitialEvent());
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
      // Body where only the products will scroll
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
                              msg: "Product Delete Sucessfully");
                        } else if (state is ProdutDeleteErrorState) {
                          Fluttertoast.showToast(msg: "Product Delete Error ");
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
                          ));
                        } else if (state is CartdataFetchSucessfullState) {
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
                                      height: 300,
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
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                (imageUrl != null &&
                                                        imageUrl.isNotEmpty)
                                                    ? imageUrl
                                                    : 'https://via.placeholder.com/150',
                                                width: 200,
                                                height: 300,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.network(
                                                    'https://via.placeholder.com/150',
                                                    width: 200,
                                                    height: 300,
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      name.length > 7
                                                          ? '${name.substring(0, 7)}...'
                                                          : name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    IconButton(
                                                      icon: Icon(Icons.close,
                                                          color: Colors.red),
                                                      onPressed: () {
                                                        cartBloc.add(
                                                            ClickedRemoveProductEvent(
                                                                id));
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  "€$price",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.orange),
                                                ),
                                                RatingBarIndicator(
                                                  rating: 4.5,
                                                  itemBuilder:
                                                      (context, index) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 20.0,
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  "Size : ${size}",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  "Color : ${color}",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                SizedBox(height: 20),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40),
                                                        border: Border.all(
                                                            color: Colors.red),
                                                      ),
                                                      child: IconButton(
                                                        icon: Icon(Icons.remove,
                                                            color: Colors.red),
                                                        onPressed: () {
                                                          setState(() {
                                                            if (quantity > 1) {
                                                              quantity--;
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      "$quantity",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: Colors.red),
                                                      ),
                                                      child: IconButton(
                                                        icon: Icon(Icons.add,
                                                            color: Colors.red),
                                                        onPressed: () {
                                                          setState(() {
                                                            quantity++;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 20),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    side: const BorderSide(
                                                        color: Colors.black),
                                                    minimumSize: Size(170, 50),
                                                  ),
                                                  onPressed: () {},
                                                  child: const Text("Detail",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 17)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                            255, 233, 233, 233),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                      )
                                    ]),
                                width: double.infinity,
                                height: 250,
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SummaryRow(
                                          label: "Sub Total", value: "€341.0"),
                                      SizedBox(height: 10),
                                      SummaryRow(
                                          label: "Shipping", value: "€25.99"),
                                      Divider(
                                          thickness: 1,
                                          color: Colors.grey.shade300),
                                      SummaryRow(
                                        label: "Total",
                                        value: "€2279.93",
                                        istotal: true,
                                      ),
                                      SizedBox(height: 30),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .zero, // No rounded corners
                                            ),
                                          ),
                                          onPressed: () {
                                            // Handle checkout
                                          },
                                          child: Text(
                                            "Checkout",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                              child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  "https://img.freepik.com/premium-vector/empty-cart_701961-7086.jpg",
                                  height: 150,
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
                                  'Your cart is empty',
                                  style: TextStyle(
                                    fontSize: 18,
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
                                    print('Navigate to Shop');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
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
                          ));
                        }
                      },
                    ),
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

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool istotal;

  const SummaryRow(
      {required this.label, required this.value, this.istotal = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: istotal ? 18 : 16,
            fontWeight: istotal ? FontWeight.bold : FontWeight.normal,
            color: istotal ? Colors.black : Colors.black,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: istotal ? 20 : 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        )
      ],
    );
  }
}
