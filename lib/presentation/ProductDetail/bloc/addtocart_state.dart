part of 'addtocart_bloc.dart';

@immutable
sealed class AddtocartState {}

final class AddtocartInitial extends AddtocartState {}

abstract class AddTocartActionState extends AddtocartState {}

class AddToCartSucessState extends AddTocartActionState {}

class CatchErrorAddToCartState extends AddTocartActionState {}
