part of 'login_bloc_bloc.dart';

@immutable
sealed class LoginBlocEvent {}

class LoginInitialEvent extends LoginBlocEvent {}

class LoginUsernameTextfeildEvent extends LoginBlocEvent {
  final String getusernamevalue;
  final String getpasswordvalue;
  LoginUsernameTextfeildEvent(
      {required this.getusernamevalue, required this.getpasswordvalue});
}

class LoginOneCharactorAccessEvent extends LoginBlocEvent {
  final String getcharEmail;
  LoginOneCharactorAccessEvent({required this.getcharEmail});
}

class LoginOneCharactorPassowrdAccessEvent extends LoginBlocEvent {
  final String getcharPassword;
  LoginOneCharactorPassowrdAccessEvent({required this.getcharPassword});
}

class GoogleButtonClickedEvent extends LoginBlocEvent {}
