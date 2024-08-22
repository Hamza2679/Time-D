// profile_state.dart
part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String phoneNumber;
  final String fullName;
  final String? profileImagePath;

  const ProfileLoaded({
    required this.phoneNumber,
    required this.fullName,
    this.profileImagePath,
  });

  @override
  List<Object?> get props => [phoneNumber, fullName, profileImagePath];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}
