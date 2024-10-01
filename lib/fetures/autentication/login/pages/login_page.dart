import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:country_picker/country_picker.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../../../../utils/authentication_repository.dart';
import '../../../home/pages/main_page.dart';
import '../../otp/pages/otp_page.dart';
import 'package:delivery_app/utils/colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _selectedCountryCode = '+251';
  String _countryFlag = '🇪🇹';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Login', style: TextStyle(color: primaryTextColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Hello Delivery',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'Login with your phone number to use the app',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter Phone Number',
                    filled: true,
                    fillColor: inputFieldColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            setState(() {
                              _selectedCountryCode = '+${country.phoneCode}';
                              _countryFlag = country.flagEmoji;
                            });
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('$_countryFlag $_selectedCountryCode'),
                            Icon(Icons.arrow_drop_down, color: greyColor),
                          ],
                        ),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                _isLoading
                    ? CircularProgressIndicator(color: loadingIndicatorColor)
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      _verifyPhoneNumber(context);
                    }
                  },
                  child: Text('Submit', style: TextStyle(color: primaryTextColor)),
                ),
                SizedBox(height: 30),
                Text(
                  'If you\'re experiencing issues logging in, please don\'t hesitate to contact us on ----.',
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _verifyPhoneNumber(BuildContext context) async {
    String phoneNumber = '$_selectedCountryCode${_phoneNumberController.text.trim()}';

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        _setLoginState();
        setState(() {
          _isLoading = false;
        });
        Get.offAll(() => MainPage());
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          _isLoading = false;
        });
        print("Verification failed: ${e.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to verify phone number: ${e.message}')),
        );
      },

      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _isLoading = false;
        });
        Get.offAll(() => OtpVerificationPage(verificationId: verificationId, phoneNumber: phoneNumber));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  void _setLoginState() async {
    String token = _generateToken();
    await AuthenticationRepository.instance.saveToken(token);
    print('Token saved: $token');
  }

  String _generateToken() {
    final payload = {
      'iss': 'delivery_app',
      'exp': DateTime.now().add(Duration(days: 180)).millisecondsSinceEpoch ~/ 1000
    };
    final token = base64UrlEncode(utf8.encode(jsonEncode(payload)));
    return token;
  }
}
