// otp_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  OtpBloc() : super(OtpInitial()) {
    on<VerifyOtp>((event, emit) async {
      emit(OtpVerifying());
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: event.verificationId,
          smsCode: event.otp,
        );
        await _firebaseAuth.signInWithCredential(credential);
        emit(OtpVerified());
      } catch (e) {
        emit(OtpFailed(e.toString()));
      }
    });

    on<ResendOtp>((event, emit) async {
      // Handle resending OTP logic here
    });
  }
}
