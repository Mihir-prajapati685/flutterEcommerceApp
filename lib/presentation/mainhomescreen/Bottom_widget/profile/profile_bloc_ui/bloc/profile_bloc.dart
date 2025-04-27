import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfilePageInitialEvent>(profilePageInitialEvent);
  }

  FutureOr<void> profilePageInitialEvent(
      ProfilePageInitialEvent event, Emitter<ProfileState> emit) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      print("🔍 FirebaseAuth.currentUser: $user");
      if (user == null) {
        print("No user logged in! Please sign in first.");
        emit(ProfileDataFromTheFirebaseDataNOtState());
        return;
      }

      String uid = user.uid;
      print("Logged-in User UID: $uid");

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('signincollection')
          .where('uid', isEqualTo: uid) // 🔥 Match 'uid' field in Firestore
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // 🔥 Get the first matching document
        DocumentSnapshot userdoc = querySnapshot.docs.first;
        print("Document ID found: ${userdoc.id}");
        print("Document Data: ${userdoc.data()}");

        Map<String, dynamic>? userdata =
            userdoc.data() as Map<String, dynamic>?;
        if (userdata != null) {
          emit(ProfileDataFromTheFirebaseState(userdata));
        } else {
          print("Error: Document exists but has no data!");
          emit(ProfileDataFromTheFirebaseDataNOtState());
        }
      } else {
        print("Error: No document found for this user!");
        emit(ProfileDataFromTheFirebaseDataNOtState());
      }
    } catch (e) {
      print("Error fetching profile data: $e");
      emit(ProfileDataFromTheFirebaseErrorState());
    }
  }
}
