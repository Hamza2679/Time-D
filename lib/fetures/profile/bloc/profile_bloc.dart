import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<UpdateProfile>(_onUpdateProfile);
  }



  void _onUpdateProfile(
      UpdateProfile event,
      Emitter<ProfileState> emit,
      ) {
    emit(event.newProfile);
  }
}
