import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'mainscreen_event.dart';
part 'mainscreen_state.dart';

class MainscreenBloc extends Bloc<MainscreenEvent, MainscreenState> {
  final http.Client client;
  MainscreenBloc({required this.client}) : super(MainscreenInitial()) {
    on<MainScreenInitialEvent>(mainScreenInitialEvent);
  }

  FutureOr<void> mainScreenInitialEvent(
    MainScreenInitialEvent event,
    Emitter<MainscreenState> emit,
  ) async {
    try {
      emit(MainScreenLoadingState());

      final fetchProduct = await http.get(
        Uri.parse('https://fakestoreapi.com/products/'),
      );
      if (fetchProduct.statusCode == 200) {
        final data = jsonDecode(fetchProduct.body);
        emit(MainScreenLoadedSuccessfullyState(data));
      } else {
        emit(MainScreenErrorState("Failed to load products"));
      }
    } catch (e) {
      emit(MainScreenErrorState(e.toString()));
    }
  }
}
