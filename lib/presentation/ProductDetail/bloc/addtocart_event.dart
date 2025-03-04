part of 'addtocart_bloc.dart';

@immutable
sealed class AddtocartEvent {}

class AddTocartButtonClick extends AddtocartEvent {
  String img;
  String name;
  String price;
  String size;
  String color;
  int quantity;

  AddTocartButtonClick(
      {required this.img,
      required this.name,
      required this.price,
      required this.size,
      required this.color,
      required this.quantity});
}
