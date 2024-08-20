// electronics_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'electronics_event.dart';
import 'electronics_state.dart';

class ElectronicsBloc extends Bloc<ElectronicsEvent, ElectronicsState> {
  ElectronicsBloc() : super(ElectronicsInitial()) {
    on<LoadElectronics>(_onLoadElectronics);
  }

  Future<void> _onLoadElectronics(LoadElectronics event, Emitter<ElectronicsState> emit) async {
    try {
      // Simulate a network call or data fetching
      await Future.delayed(Duration(seconds: 2));

      // For demonstration, we use a static list
      final electronics = ['TV', 'Radio', 'Laptop'];

      emit(ElectronicsLoaded(electronics));
    } catch (e) {
      emit(ElectronicsError('Failed to load electronics'));
    }
  }
}
