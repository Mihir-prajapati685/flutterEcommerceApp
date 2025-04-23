part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

abstract class CartActionState extends CartState {}

class CartdataFetchSucessfullState extends CartActionState {
  List<Map<String, dynamic>> cartdata;
  CartdataFetchSucessfullState(this.cartdata);
}

class CartFetchdataErrorState extends CartActionState {}

class ProductDeleteSucessState extends CartActionState {}

class ProdutDeleteErrorState extends CartActionState {}

class FirebasedatabaseEmptyState extends CartActionState {}

class ProductDeleteErrorState extends CartActionState {}

