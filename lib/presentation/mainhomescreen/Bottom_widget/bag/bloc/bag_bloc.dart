import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../Data/Women_catogry_data.dart';
import '../../../../../Data/men_categotry_data.dart';
import '../../../../../Data/kids_category_data.dart';
part 'bag_event.dart';
part 'bag_state.dart';

class BagBloc extends Bloc<BagEvent, BagState> {
  BagBloc() : super(BagInitial()) {
    on<WomenCategoryLoadEvent>(categoryLoadEvent);
    // on<WomenCategoryButtonClickedIdEvent>(womenCategoryButtonClickedIdEvent);
    on<MenCategoryLoadEvent>(menCategoryLoadEvent);
    on<KidsCategoryLoadEvent>(kidsCategoryLoadEvent);
  }

  FutureOr<void> categoryLoadEvent(
      WomenCategoryLoadEvent event, Emitter<BagState> emit) {
    try {
      emit(WomenCategoryLoadedState(womencategory: wcdata));
    } catch (e) {
      emit(CathcErrorWomenState());
    }
  }

  FutureOr<void> menCategoryLoadEvent(
      MenCategoryLoadEvent event, Emitter<BagState> emit) {
    try {
      if (mcdata == null) {
        throw Exception("mc data is null");
      }
      emit(MenCategoryLoadedState(mencategory: mcdata));
    } catch (e) {
      emit(CathcErrorMenState());
    }
  }

  FutureOr<void> kidsCategoryLoadEvent(
      KidsCategoryLoadEvent event, Emitter<BagState> emit) {
    try {
      if (kcdata == null) {
        throw Exception("mc data is null");
      }
      emit(KidsCategoryLoadedState(kidscategory: kcdata));
    } catch (e) {
      emit(CathcErrorKidsState());
    }
  }
}
