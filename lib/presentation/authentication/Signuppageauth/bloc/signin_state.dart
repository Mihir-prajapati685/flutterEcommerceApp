part of 'signin_bloc.dart';

@immutable
sealed class SigninState {}

final class SigninInitial extends SigninState {}

abstract class SigninActionState extends SigninState {}

class UsernamefieldIsEmpty extends SigninActionState {}

class EmailfieldIsEmpty extends SigninActionState {}

class PasswordfieldIsEmpty extends SigninActionState {}

class AlreadyEmailExistState extends SigninActionState {}

class SuccessfullSignInState extends SigninActionState {}

class SignInErrorState extends SigninState {
  final String error;
  SignInErrorState({required this.error});
}

class AtTheRateNotContainState extends SigninActionState {}

class GoogleButtonClickedState extends SigninActionState {}

class GoogleSignInCancelledState extends SigninActionState {}

class SuccessfullGoogleSignInState extends SigninActionState {
  final User user;
  SuccessfullGoogleSignInState({required this.user});
}
