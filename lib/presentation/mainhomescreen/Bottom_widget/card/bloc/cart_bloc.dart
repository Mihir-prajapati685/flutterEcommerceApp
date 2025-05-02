import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      // emit(CartLoadingState()); // Optional: show loading spinner

      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('addtocart')
            .where('userId',
                isEqualTo: user.uid) // 👈 ensure this matches Firestore
            .get();

        if (querySnapshot.docs.isEmpty) {
          emit(FirebasedatabaseEmptyState());
        } else {
          List<Map<String, dynamic>> data = querySnapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();

          emit(CartdataFetchSucessfullState(data));
        }
      } else {
        // emit(
        //     CartUserNotLoggedInState());
        // Optional: to handle unauthenticated users
        print("hiiiiiiiiiiiiiii");
      }
    } catch (e) {
      print("Error fetching cart data: $e");
      emit(CartFetchdataErrorState());
    }
  }

  FutureOr<void> clickedRemoveProductEvent(
      ClickedRemoveProductEvent event, Emitter<CartState> emit) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final collection = FirebaseFirestore.instance.collection('addtocart');

      QuerySnapshot snapshot = await collection
          .where('id', isEqualTo: int.parse(event.productId))
          .where('userId', isEqualTo: user.uid)
          .get();

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
      emit(CartFetchdataErrorState());
    }
  }
}
