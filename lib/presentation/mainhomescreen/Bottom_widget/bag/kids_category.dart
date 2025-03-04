import 'package:ecommerce_app/presentation/Productcartscreen/categoryWishCard.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/bag/bloc/bag_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class KidsCategory extends StatefulWidget {
  @override
  State<KidsCategory> createState() => _KidsCategory();
}

class _KidsCategory extends State<KidsCategory> {
  final BagBloc bagBloc = BagBloc();
  @override
  void initState() {
    super.initState();
    bagBloc.add(KidsCategoryLoadEvent());
  }

  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: bagBloc,
        listener: (context, state) {
          if (state is CathcErrorKidsState) {
            Fluttertoast.showToast(msg: 'error catch ');
          }
        },
        builder: (context, state) {
          if (state is KidsCategoryLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is KidsCategoryLoadedState) {
            return Expanded(
              child: ListView.builder(
                  itemCount: state.kidscategory.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color.fromARGB(255, 243, 76, 64),
                            width: 1),
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
                              state.kidscategory[index]['title'] ?? "no name",
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
                                    state.kidscategory[index]["image"] ??
                                        "no image",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                          Positioned(
                              left: 20,
                              bottom: 10,
                              child: Container(
                                  child: IconButton(
                                onPressed: () {
                                  final categoryId = state.kidscategory[index]
                                          ['id'] ??
                                      "null value";
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Womencards(
                                              categoryid: categoryId)));
                                },
                                icon: Icon(
                                  Icons.arrow_circle_right_sharp,
                                  size: 30,
                                  color: Colors.red,
                                ),
                              ))),
                        ],
                      ),
                    );
                  }),
            );
          }
          return Container();
        });
  }
}
