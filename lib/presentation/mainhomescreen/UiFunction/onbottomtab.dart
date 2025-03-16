import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/bag/bag.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/card/cart.dart';
import 'package:ecommerce_app/presentation/mainhomescreen/Bottom_widget/profile/profile_bloc_ui/profile.dart';
import 'package:flutter/material.dart';

onItemTapped(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.pop(context);
      break;
    case 1:
      Navigator.push(context, MaterialPageRoute(builder: (context) => Bag()));
      break;
    case 2:
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Profile()));
      break;
    case 3:
      Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
      break;
    // case 4:
    //   Navigator.push(context,MaterialPageRoute(builder: (context)=>));
    //   break;
  }
}
