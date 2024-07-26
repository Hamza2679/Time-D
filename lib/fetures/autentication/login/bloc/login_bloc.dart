import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../otp/pages/otp_page.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String _phoneNumber = '';
  String _countryCode = '+251';

  LoginBloc() : super(LoginInitial()) {
    on<PhoneNumberChanged>((event, emit) {
      _phoneNumber = event.phoneNumber;
    });

    on<CountryCodeChanged>((event, emit) {
      _countryCode = event.countryCode;
    });

    on<SubmitPhoneNumber>((event, emit) async {
      emit(LoginLoading());
      try {
        await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: '$_countryCode$_phoneNumber',
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _firebaseAuth.signInWithCredential(credential);
            emit(LoginSuccess());
          },
          verificationFailed: (FirebaseAuthException e) {
            emit(LoginFailure(e.message ?? 'Unknown error'));
          },
          codeSent: (String verificationId, int? resendToken) {
            // Navigate to the OTP page
            Navigator.push(
              event.context, // Pass context through event
              MaterialPageRoute(
                builder: (context) => OtpVerificationPage(
                  phoneNumber: '$_countryCode$_phoneNumber',
                  verificationId: verificationId,
                ),
              ),
            );
            emit(LoginCodeSent(verificationId)); // Add this state to handle in the UI
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
