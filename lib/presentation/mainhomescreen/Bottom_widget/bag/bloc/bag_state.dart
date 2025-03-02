part of 'bag_bloc.dart';

@immutable
sealed class BagState {}

final class BagInitial extends BagState {}

abstract class BagActionState extends BagState {}

class WomenCategoryLoadingState extends BagActionState {}

class WomenCategoryLoadedState extends BagActionState {
  List<Map<String, String>> womencategory;
  WomenCategoryLoadedState({required this.womencategory});
}

class CathcErrorWomenState extends BagActionState {}

class WCButtonOnclickThenNavigateToIdState extends BagActionState{
  
}
