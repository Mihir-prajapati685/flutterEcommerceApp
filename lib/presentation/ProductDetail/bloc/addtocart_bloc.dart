import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'addtocart_event.dart';
part 'addtocart_state.dart';

class AddtocartBloc extends Bloc<AddtocartEvent, AddtocartState> {
  AddtocartBloc() : super(AddtocartInitial()) {
    on<AddTocartButtonClick>(addTocartButtonClick);
  }

  FutureOr<void> addTocartButtonClick(
      AddTocartButtonClick event, Emitter<AddtocartState> emit) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        // Handle case: user not logged in
        print("user not found");
        emit(CatchErrorAddToCartState());
        return;
      }

      print("useruid ${user.uid}");
      CollectionReference collref =
          FirebaseFirestore.instance.collection('addtocart');

      // Check if product with same ID and same user already exists
      QuerySnapshot querySnapshot = await collref
          .where('uid', isEqualTo: user.uid)
          .where('id', isEqualTo: event.id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        emit(AlreadyProductExistTocartState());
      } else {
        await collref.add({
          'uid': user.uid, // 👈 Add this!
          'id': event.id,
          'img': event.img,
          'name': event.name,
          'price': event.price,
          'size': event.size,
          'color': event.color,
          'quantity': event.quantity,
        });
        emit(AddToCartSucessState());
      }
    } catch (e) {
      emit(CatchErrorAddToCartState());
    }
  }
}
