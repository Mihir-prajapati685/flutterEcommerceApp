
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => Cart_widget();
}

class Cart_widget extends State<Cart> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("this is cart"),
      ),
    );
  }
}