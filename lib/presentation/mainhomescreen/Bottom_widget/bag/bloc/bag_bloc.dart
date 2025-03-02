import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../Data/Women_catogry_data.dart';

part 'bag_event.dart';
part 'bag_state.dart';

class BagBloc extends Bloc<BagEvent, BagState> {
  BagBloc() : super(BagInitial()) {
    on<WomenCategoryLoadEvent>(categoryLoadEvent);
    on<WomenCategoryButtonClickedIdEvent>(womenCategoryButtonClickedIdEvent);
  }

  FutureOr<void> categoryLoadEvent(
      WomenCategoryLoadEvent event, Emitter<BagState> emit) {
    try {
      emit(WomenCategoryLoadedState(womencategory: wcdata));
    } catch (e) {
      emit(CathcErrorWomenState());
    }
  }

  FutureOr<void> womenCategoryButtonClickedIdEvent(
      WomenCategoryButtonClickedIdEvent event, Emitter<BagState> emit) {
    emit(WCButtonOnclickThenNavigateToIdState());
  }
}
