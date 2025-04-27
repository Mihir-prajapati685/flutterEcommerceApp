import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninInitial()) {
    on<SignInButtonClickedEvent>(signInButtonClickedEvent);
    // on<GoogleButtonClickedEvent>(googleButtonClickedEvent);
  }

  FutureOr<void> signInButtonClickedEvent(
      SignInButtonClickedEvent event, Emitter<SigninState> emit) async {
    if (event.username.isEmpty) {
      emit(UsernamefieldIsEmpty());
      return;
    }
    if (event.email.isEmpty) {
      emit(EmailfieldIsEmpty());
      return;
    }
    if (event.password.isEmpty) {
      emit(PasswordfieldIsEmpty());
      return;
    }
    if (!event.email.contains('@')) {
      emit(AtTheRateNotContainState());
    } else {
      CollectionReference collref =
          FirebaseFirestore.instance.collection('signincollection');

      // Check if email already exists
      QuerySnapshot querySnapshotEmail =
          await collref.where('email', isEqualTo: event.email).get();

      if (querySnapshotEmail.docs.isNotEmpty) {
        emit(AlreadyEmailExistState()); // Email already exists
      } else {
        try {
          // 🔐 Create user in Firebase Auth
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );

          User? user = userCredential.user;

          // ✅ Send email verification
          if (user != null && !user.emailVerified) {
            await user.sendEmailVerification();
          }

          // 💾 Save user info to Firestore only after creating account
          if (user != null) {
            // Check if user is not null before accessing uid
            await collref.add({
              'username': event.username,
              'email': event.email,
              'password': event.password,
              'uid': user.uid, // Now safely accessing user.uid
            });

            // Now, sign in the user after successful registration
            await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );

            emit(SuccessfullSignInState()); // You can handle navigation in UI
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'email-already-in-use') {
            emit(AlreadyEmailExistState());
          } else {
            emit(SignInErrorState(error: e.message ?? "Unknown error"));
          }
        } catch (e) {
          emit(SignInErrorState(error: e.toString()));
        }
      }
    }
  }

  // FutureOr<void> googleButtonClickedEvent(
  //     GoogleButtonClickedEvent event, Emitter<SigninState> emit) async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final GoogleSignIn googleSignIn = GoogleSignIn();

  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await googleSignIn.signIn();

  //     if (googleSignInAccount == null) {
  //       emit(GoogleSignInCancelledState()); // Emit state for cancellation
  //       return;
  //     }

  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount.authentication;

  //     final AuthCredential authCredential = GoogleAuthProvider.credential(
  //       idToken: googleSignInAuthentication.idToken,
  //       accessToken: googleSignInAuthentication.accessToken,
  //     );

  //     UserCredential result = await auth.signInWithCredential(authCredential);
  //     User? user = result.user;

  //     if (user != null) {
  //       emit(SuccessfullGoogleSignInState(user: user)); // Emit success state
  //     }
  //   } catch (error) {
  //     emit(SignInErrorState(error: error.toString())); // Emit error state
  //   }
  // }
}
