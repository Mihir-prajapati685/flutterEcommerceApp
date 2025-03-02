part of 'signin_bloc.dart';

@immutable
sealed class SigninEvent {}

class SigninInitialEvent extends SigninEvent {}

class SignInButtonClickedEvent extends SigninEvent {
  String username;
  String email;
  String password;

  SignInButtonClickedEvent(
      {required this.username, required this.email, required this.password});
}

// class GoogleButtonClickedEvent extends SigninEvent{
// }
