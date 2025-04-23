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
      var collection = FirebaseFirestore.instance.collection('addtocart');

      // Fetch the product by id to be deleted from Firestore
      var snapshot =
          await collection.where('id', isEqualTo: event.productId).get();

      if (snapshot.docs.isNotEmpty) {
        // Delete the document in Firestore
        for (var doc in snapshot.docs) {
          await doc.reference.delete();
        }

        // Emit success state if product is deleted successfully
        emit(ProductDeleteSucessState()); // Send the id of the deleted product
      } else {
        // If no product is found with the given ID
        emit(ProductDeleteErrorState());
      }
    } catch (e) {
      // Handle any errors during the product removal
      emit(ProductDeleteErrorState());
    }
  }
}
