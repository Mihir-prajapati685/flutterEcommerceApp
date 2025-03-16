part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CarPageInitialEvent extends CartEvent {}

class ClickedRemoveProductEvent extends CartEvent {
  final String productId;
  ClickedRemoveProductEvent(this.productId);
}
