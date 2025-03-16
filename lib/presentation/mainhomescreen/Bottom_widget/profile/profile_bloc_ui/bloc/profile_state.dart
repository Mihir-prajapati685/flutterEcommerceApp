part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

abstract class ProfileActionState extends ProfileState {}

class ProfileDataFromTheFirebaseState extends ProfileActionState {
  Map<String, dynamic> profiledata;
  ProfileDataFromTheFirebaseState(this.profiledata);
}
class ProfileDataFromTheFirebaseDataNOtState extends ProfileActionState{}
class ProfileDataFromTheFirebaseErrorState extends ProfileActionState {}
