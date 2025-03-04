part of 'bag_bloc.dart';

@immutable
sealed class BagEvent {}

class WomenCategoryLoadEvent extends BagEvent {}

class MenCategoryLoadEvent extends BagEvent {}

class KidsCategoryLoadEvent extends BagEvent {}
