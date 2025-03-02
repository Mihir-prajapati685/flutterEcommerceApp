part of 'mainscreen_bloc.dart';

@immutable
sealed class MainscreenState {}

final class MainscreenInitial extends MainscreenState {}

class MainScreenLoadingState extends MainscreenState {}

class MainScreenLoadedSuccessfullyState extends MainscreenState {
  final List<dynamic> product; // ✅ Expecting List

  MainScreenLoadedSuccessfullyState(this.product);
}

class MainScreenErrorState extends MainscreenState {
  final String message;
  MainScreenErrorState(this.message);
}
