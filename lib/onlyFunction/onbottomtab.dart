import 'package:ecommerce_app/bag.dart';
import 'package:flutter/material.dart';
onItemTapped(BuildContext context,int index){
  switch(index){
    case 0:
      Navigator.pop(context);
      break;
    case 1:
      Navigator.push(context,MaterialPageRoute(builder: (context)=>Bag()));
      break;
    case 2:
      Navigator.pop(context);
      break;
    case 3:
      Navigator.pop(context);
      break;
    case 4:
      Navigator.pop(context);
      break;
    case 5:
      Navigator.pop(context);
      break;
  }

}