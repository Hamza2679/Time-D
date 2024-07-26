import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  OtpBloc() : super(OtpInitial()) {
    on<OtpChanged>((event, emit) {
      // Handle OTP change logic if needed
    });

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
        emit(OtpVerificationFailed(e.toString()));
      }
    });

    on<ResendOtp>((event, emit) async {
      try {
        await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: event.phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _firebaseAuth.signInWithCredential(credential);
            emit(OtpVerified());
          },
          verificationFailed: (FirebaseAuthException e) {
            emit(OtpVerificationFailed(e.message ?? 'Unknown error'));
          },
          codeSent: (String verificationId, int? resendToken) {
            emit(OtpResent(verificationId));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } catch (e) {
        emit(OtpVerificationFailed(e.toString()));
      }
    });
  }
}
