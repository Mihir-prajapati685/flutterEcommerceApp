part of 'login_bloc_bloc.dart';

@immutable
sealed class LoginBlocState {}

final class LoginBlocInitial extends LoginBlocState {}

abstract class LoginActionState extends LoginBlocState {}

class LoginUsernameTextfeildSucessState extends LoginActionState {}

class LoginUsernameEmptyStateError extends LoginActionState {
  final String errormessage1;
  LoginUsernameEmptyStateError({required this.errormessage1});
}

class LoginUsernameNotContainStateError extends LoginActionState {
  final String errormessage2;
  LoginUsernameNotContainStateError({required this.errormessage2});
}

class LoginInitialState extends LoginActionState {}

class LoginUsernameOneCharatorTextfeildSucessState extends LoginActionState {}

class LoginPasswordEmptyStateError extends LoginActionState {
  final String passerror;
  LoginPasswordEmptyStateError({required this.passerror});
}

class LoginPasswordsucessfullState extends LoginActionState {}

class GoogleSignInCancelledState extends LoginActionState {}

class SuccessfullGoogleSignInState extends LoginActionState {
  final User user;
  SuccessfullGoogleSignInState({required this.user});
}

class SignInErrorState extends LoginActionState {
  final String error;
  SignInErrorState({required this.error});
}

class EmailNotMatchState extends LoginActionState {}

class PasswordNotMatchState extends LoginActionState {}

class AlreadyLoggedInState extends LoginActionState {
  final User user;

  AlreadyLoggedInState({required this.user});
}

class CatchErrorState extends LoginActionState {
  final String error;
  CatchErrorState({required this.error});
}
