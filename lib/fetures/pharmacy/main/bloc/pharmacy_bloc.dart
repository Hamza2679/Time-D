import 'package:flutter_bloc/flutter_bloc.dart';
import 'pharmacy_event.dart';
import 'pharmacy_state.dart';
import '../../../../repositories/pharmacy_data.dart'; // Ensure correct path

class PharmacyBloc extends Bloc<PharmacyEvent, PharmacyState> {
  PharmacyBloc() : super(PharmacyInitial()) {
    on<LoadPharmacies>(_onLoadPharmacies);
  }

  void _onLoadPharmacies(LoadPharmacies event, Emitter<PharmacyState> emit) async {
    emit(PharmacyLoading());
    try {
      await Future.delayed(Duration(seconds: 1));
      emit(PharmacyLoaded(pharmacies)); // Make sure 'pharmacies' is not empty
    } catch (e) {
      emit(PharmacyError('Failed to load pharmacies'));
    }
  }
}
