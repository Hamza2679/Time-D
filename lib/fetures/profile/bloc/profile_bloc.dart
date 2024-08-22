// profile_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchPhoneNumber>(_onFetchPhoneNumber);
    on<UpdateProfile>(_onUpdateProfile);
  }

  Future<void> _onFetchPhoneNumber(
      FetchPhoneNumber event,
      Emitter<ProfileState> emit,
      ) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      final phoneNumber = user?.phoneNumber ?? 'No phone number';
      emit(ProfileLoaded(phoneNumber: phoneNumber, fullName: '', profileImagePath: null));
    } catch (e) {
      emit(ProfileError(message: 'Failed to fetch phone number'));
    }
  }

  void _onUpdateProfile(
      UpdateProfile event,
      Emitter<ProfileState> emit,
      ) {
    emit(event.newProfile);
  }
}
