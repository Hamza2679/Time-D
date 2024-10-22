import 'dart:convert';
import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

enum _ForgotPasswordStep {
  enterEmail,
  enterOTP,
  enterNewPassword,
}

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  _ForgotPasswordStep _currentStep = _ForgotPasswordStep.enterEmail;
  bool isSendingOtp = false;
  bool isVerifyingOtp = false;
  bool isResettingPassword = false;
  Future<void> _sendOtp() async {
    final email = _emailController.text;
    if (email.isEmpty) {
      _showMessage('Please enter your email.',redColor);
      return;
    }

    final url = Uri.parse('https://hello-delivery.onrender.com/api/v1/auth/forgot');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
        }),
      );

      if (response.statusCode == 201) {
        setState(() {
          _currentStep = _ForgotPasswordStep.enterOTP;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP has been sent to $email')),
        );
      } else {
        final responseBody = json.decode(response.body);
        _showMessage(responseBody['message'] ?? 'Failed to send OTP. Please try again.',redColor);
      }
    } catch (error) {
      _showMessage('An error occurred. Please check your internet connection and try again.',redColor);
    }
  }

  Future<void> _verifyOtp() async {
    final otp = _otpController.text;
    if (otp.isEmpty) {
      _showMessage('Please enter the OTP.',redColor);
      return;
    }

    setState(() {
      _currentStep = _ForgotPasswordStep.enterNewPassword;
    });
  }

  Future<void> _resetPassword() async {
    final email = _emailController.text;
    final otp = int.tryParse(_otpController.text);
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      _showMessage('Please fill in all fields.', redColor);
      return;
    }

    if (newPassword != confirmPassword) {
      _showMessage('Passwords do not match.', redColor);
      return;
    }

    if (otp == null) {
      _showMessage('Please enter a valid OTP.', redColor);
      return;
    }

    final url = Uri.parse('https://hello-delivery.onrender.com/api/v1/auth/verify');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'vCode': otp,
          'email': email,
          'password': newPassword,
        }),
      );

      if (response.statusCode == 201) {
        _showMessage('Password has been reset successfully', greenColor);

        Navigator.pop(context);
      } else {
        final responseBody = json.decode(response.body);
        _showMessage(responseBody['message'] ?? 'Failed to reset password. Please try again.', redColor);
      }
    } catch (error) {
      _showMessage('An error occurred. Please check your internet connection and try again.', redColor);
    }
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Forgot Password',style: TextStyle(color: primaryTextColor),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildCurrentStep(),
      ),
    );
  }
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  Widget _buildPasswordField(TextEditingController controller, String hintText, bool isPasswordVisible, VoidCallback onVisibilityToggle) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: onVisibilityToggle,
        ),
      ),
      obscureText: !isPasswordVisible,
    );
  }

  @override
  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case _ForgotPasswordStep.enterEmail:
        return Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),


    ElevatedButton(
    onPressed: () async {
    setState(() {
    isSendingOtp = true;
    });
    await _sendOtp();
    setState(() {
    isSendingOtp = false;
    });
    },
    style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: primaryColor,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    ),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    elevation: 5,
    ),
    child: isSendingOtp
    ? CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    )
        : Text(
    'Send OTP',
    style: TextStyle(fontSize: 16),
    ),
    ),

    ],
        );

      case _ForgotPasswordStep.enterOTP:
        return Column(
          children: [
            TextFormField(
              controller: _otpController,
              decoration: InputDecoration(
                hintText: 'Enter OTP',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isVerifyingOtp = true;
                });
                await _verifyOtp();
                setState(() {
                  isVerifyingOtp = false;
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                elevation: 5,
              ),
              child: isVerifyingOtp
                  ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
                  : Text(
                'Verify OTP',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );

      case _ForgotPasswordStep.enterNewPassword:
        return Column(
          children: [
            _buildPasswordField(
              _newPasswordController,
              'Enter new password',
              _isNewPasswordVisible,
                  () {
                setState(() {
                  _isNewPasswordVisible = !_isNewPasswordVisible;
                });
              },
            ),
            SizedBox(height: 16.0),
            _buildPasswordField(
              _confirmPasswordController,
              'Confirm new password',
              _isConfirmPasswordVisible,
                  () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isResettingPassword = true;
                });
                await _resetPassword();
                setState(() {
                  isResettingPassword = false;
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                elevation: 5,
              ),
              child: isResettingPassword
                  ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
                  : Text(
                'Reset Password',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );

      default:
        return Container();
    }
  }}
