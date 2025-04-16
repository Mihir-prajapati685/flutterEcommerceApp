import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBlocBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBlocBloc() : super(LoginBlocInitial()) {
    on<LoginInitialEvent>(loginInitialEvent);
    on<LoginUsernameTextfeildEvent>(loginUsernameTextfeildEvent);
    on<LoginOneCharactorAccessEvent>(loginOneCharactorAccessEvent);
    on<LoginOneCharactorPassowrdAccessEvent>(
        loginOneCharactorPassowrdAccessEvent);
    on<GoogleButtonClickedEvent>(googleButtonClickedEvent);
  }

  FutureOr<void> loginInitialEvent(
      LoginInitialEvent event, Emitter<LoginBlocState> emit) {
    emit(LoginInitialState());
  }

  FutureOr<void> loginUsernameTextfeildEvent(
      LoginUsernameTextfeildEvent event, Emitter<LoginBlocState> emit) async {
    if (event.getusernamevalue.isEmpty) {
      emit(LoginUsernameEmptyStateError(
          errormessage1: "Please Enter the Email"));
    } else if (event.getpasswordvalue.isEmpty) {
      emit(
          LoginPasswordEmptyStateError(passerror: "Please Enter the password"));
    } else {
      try {
        CollectionReference collref =
            FirebaseFirestore.instance.collection("signincollection");
        QuerySnapshot querySnapshotemail = await collref
            .where('email', isEqualTo: event.getusernamevalue)
            .get();
        QuerySnapshot querySnapshotpassword = await collref
            .where('password', isEqualTo: event.getpasswordvalue)
            .get();
        if (querySnapshotemail.docs.isEmpty) {
          emit(EmailNotMatchState());
        } else if (querySnapshotpassword.docs.isEmpty) {
          emit(PasswordNotMatchState());
        } else if (querySnapshotemail.docs.isNotEmpty &&
            querySnapshotpassword.docs.isNotEmpty) {
          emit(LoginUsernameTextfeildSucessState());
        }
      } catch (e) {
        emit(CatchErrorState(error: e.toString()));
      }
    }
    // if (!event.getusernamevalue.isEmpty && !event.getpasswordvalue.isEmpty) {
    // }
  }

  FutureOr<void> loginOneCharactorAccessEvent(
      LoginOneCharactorAccessEvent event, Emitter<LoginBlocState> emit) {
    if (!event.getcharEmail.contains('@')) {
      emit(LoginUsernameNotContainStateError(
          errormessage2: "please required @ in email"));
    } else if (event.getcharEmail.isEmpty) {
      emit(LoginUsernameEmptyStateError(
          errormessage1: "please Enter the Email"));
    } else {
      emit(LoginUsernameOneCharatorTextfeildSucessState());
    }
  }

  FutureOr<void> loginOneCharactorPassowrdAccessEvent(
      LoginOneCharactorPassowrdAccessEvent event,
      Emitter<LoginBlocState> emit) {
    if (event.getcharPassword.isEmpty) {
      emit(LoginPasswordEmptyStateError(passerror: 'enter the password'));
    } else {
      emit(LoginPasswordsucessfullState());
    }
  }

  FutureOr<void> googleButtonClickedEvent(
      GoogleButtonClickedEvent event, Emitter<LoginBlocState> emit) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        emit(GoogleSignInCancelledState()); // Emit state for cancellation
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;

      if (user != null) {
        emit(SuccessfullGoogleSignInState(user: user)); // Emit success state
      }
    } catch (error) {
      emit(SignInErrorState(error: error.toString())); // Emit error state
    }
  }
  
}
