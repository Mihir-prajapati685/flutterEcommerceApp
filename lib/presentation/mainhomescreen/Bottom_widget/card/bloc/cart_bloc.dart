import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CarPageInitialEvent>(carPageInitialEvent);
    on<ClickedRemoveProductEvent>(clickedRemoveProductEvent);
  }

  FutureOr<void> carPageInitialEvent(
      CarPageInitialEvent event, Emitter<CartState> emit) async {
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot =
          await _firestore.collection('addtocart').get();
      if (querySnapshot.docs.isEmpty) {
        emit(FirebasedatabaseEmptyState());
      } else {
        List<Map<String, dynamic>> data = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        emit(CartdataFetchSucessfullState(data));
      }
    } catch (e) {
      emit(CartFetchdataErrorState());
    }
  }

  FutureOr<void> clickedRemoveProductEvent(
      ClickedRemoveProductEvent event, Emitter<CartState> emit) async {
    try {
      var collection = FirebaseFirestore.instance.collection('AddToCart');
      var snapshot =
          await collection.where('id', isEqualTo: event.productId).get();
      for (var doc in snapshot.docs) {
        await doc.reference.delete(); // Delete document by reference
      }
      emit(ProductDeleteSucessState());
    } catch (e) {
      emit(ProdutDeleteErrorState());
    }
  }
}
