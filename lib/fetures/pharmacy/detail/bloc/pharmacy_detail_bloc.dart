// pharmacy_detail_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../repositories/pharmacy_data.dart';
import 'pharmacy_detail_event.dart';
import 'pharmacy_detail_state.dart';
import '../../../../repositories/pharmacy_data.dart';

class PharmacyDetailBloc extends Bloc<PharmacyDetailEvent, PharmacyDetailState> {
  PharmacyDetailBloc() : super(PharmacyDetailInitial()) {
    on<LoadPharmacyDetails>(_onLoadPharmacyDetails);
  }


  void _onLoadPharmacyDetails(LoadPharmacyDetails event, Emitter<PharmacyDetailState> emit) async {
    emit(PharmacyDetailLoading());
    try {
      await Future.delayed(Duration(seconds: 1));
      emit(PharmacyDetailLoaded(event.pharmacy.drugs));  // Access the drugs from the pharmacy instance
    } catch (e) {
      emit(PharmacyDetailError('Failed to load pharmacy details'));
    }
  }

}
