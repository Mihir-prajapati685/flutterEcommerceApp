part of 'bag_bloc.dart';

@immutable
sealed class BagState {}

final class BagInitial extends BagState {}

abstract class BagActionState extends BagState {}

//for women category//

class WomenCategoryLoadingState extends BagActionState {}

// ignore: must_be_immutable
class WomenCategoryLoadedState extends BagActionState {
  List<Map<String, String>> womencategory;
  WomenCategoryLoadedState({required this.womencategory});
}

class CathcErrorWomenState extends BagActionState {}

//for men category//

class MenCategoryLoadingState extends BagActionState {}

// ignore: must_be_immutable
class MenCategoryLoadedState extends BagActionState {
  List<Map<String, String>> mencategory;
  MenCategoryLoadedState({required this.mencategory});
}

class CathcErrorMenState extends BagActionState {}

//for kids category

class KidsCategoryLoadingState extends BagActionState {}

// ignore: must_be_immutable
class KidsCategoryLoadedState extends BagActionState {
  List<Map<String, String>> kidscategory;
  KidsCategoryLoadedState({required this.kidscategory});
}

class CathcErrorKidsState extends BagActionState {}
