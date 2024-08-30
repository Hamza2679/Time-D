import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<NextScreenEvent>((event, emit) {
      emit(SplashNavigate(event.nextScreen));
    });
  }
}
