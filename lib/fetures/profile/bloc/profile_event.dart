part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchPhoneNumber extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final ProfileLoaded newProfile;

  const UpdateProfile(this.newProfile);

  @override
  List<Object?> get props => [newProfile];
}
