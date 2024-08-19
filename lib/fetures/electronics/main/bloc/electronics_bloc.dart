import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'electronics_event.dart';
import 'electronics_state.dart';

class ElectronicsBloc extends Bloc<ElectronicsEvent, ElectronicsState> {
  final List<Map<String, dynamic>> _stores;

  ElectronicsBloc(this._stores) : super(ElectronicsInitial()) {
    on<LoadElectronics>((event, emit) async {
      try {
        // Simulate loading data
        await Future.delayed(Duration(seconds: 1));
        emit(ElectronicsLoaded(_stores));
      } catch (e) {
        emit(ElectronicsError('Failed to load electronics'));
      }
    });
  }
}
