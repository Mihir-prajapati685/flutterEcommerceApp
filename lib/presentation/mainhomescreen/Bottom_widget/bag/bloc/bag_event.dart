part of 'bag_bloc.dart';

@immutable
sealed class BagEvent {}

class WomenCategoryLoadEvent extends BagEvent {}

class WomenCategoryButtonClickedIdEvent extends BagEvent {
  final String id;
  WomenCategoryButtonClickedIdEvent(this.id);
}
