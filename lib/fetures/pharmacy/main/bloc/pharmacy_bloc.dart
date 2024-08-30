import 'package:flutter_bloc/flutter_bloc.dart';
import 'pharmacy_event.dart';
import 'pharmacy_state.dart';
import '../../../../repositories/pharmacy_data.dart';

class PharmacyBloc extends Bloc<PharmacyEvent, PharmacyState> {
  PharmacyBloc() : super(PharmacyInitial()) {
    on<LoadPharmacies>(_onLoadPharmacies);
  }

  void _onLoadPharmacies(LoadPharmacies event, Emitter<PharmacyState> emit) async {
    emit(PharmacyLoading());
    try {
      await Future.delayed(Duration(seconds: 0));
      emit(PharmacyLoaded(pharmacies));
    } catch (e) {
      emit(PharmacyError('Failed to load pharmacies'));
    }
  }
}
