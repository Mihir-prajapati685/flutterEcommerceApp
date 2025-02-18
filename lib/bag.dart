
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bag extends StatefulWidget {
  @override
  State<Bag> createState() => Bag_widget();
}

class Bag_widget extends State<Bag> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("this is bag"),
      ),
    );
  }
}