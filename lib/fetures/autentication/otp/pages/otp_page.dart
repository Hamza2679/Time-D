import 'package:delivery_app/fetures/home/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/otp_bloc.dart';
import '../bloc/otp_event.dart';
import '../bloc/otp_state.dart';

class OtpVerificationPage extends StatelessWidget {
  final String phoneNumber;
  final String verificationId;

  OtpVerificationPage({required this.phoneNumber, required this.verificationId});

  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('OTP Verification', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the OTP',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, color: Colors.deepOrange, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 40,
                  child: TextField(
                    controller: _otpControllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      context.read<OtpBloc>().add(OtpChanged(value));
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                      }
                      if (index == 5 && value.isNotEmpty) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                  ),
                );
              }),
            ),
            SizedBox(height: 30),
            Center(
              child: BlocConsumer<OtpBloc, OtpState>(
                listener: (context, state) {
                  if (state is OtpVerified) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                          (Route<dynamic> route) => false,
                    );
                  } else if (state is OtpVerificationFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('OTP verification failed: ${state.error}')),
                    );
                  } else if (state is OtpResent) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('OTP resent successfully')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is OtpVerifying) {
                    return CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                    ),
                    onPressed: () {
                      String otp = _otpControllers.map((controller) => controller.text).join();
                      context.read<OtpBloc>().add(VerifyOtp(verificationId, otp));
                    },
                    child: Text('Verify OTP', style: TextStyle(color: Colors.white)),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                context.read<OtpBloc>().add(ResendOtp(phoneNumber));
              },
              child: Text(
                "Didn't receive code? Resend",
                style: TextStyle(color: Colors.deepOrange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}