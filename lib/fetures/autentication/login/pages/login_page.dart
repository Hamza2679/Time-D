import 'dart:convert';
import 'package:delivery_app/fetures/autentication/signUp/pages/signup_page.dart';
import 'package:delivery_app/fetures/home/pages/main_page.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:country_picker/country_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../forgetPassword/pages/forgetPassword_Pages.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _emailController = TextEditingController();
  final _emailPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _phonePasswordController = TextEditingController();
  String _selectedCountryCode = '+251';
  String _countryFlag = '🇪🇹';
  final String baseUrl = 'https://hello-delivery.onrender.com/api/v1';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
    );
  }

  Future<void> _loginWithPhone() async {
    final phoneNumber = '$_selectedCountryCode${_phoneController.text}';
    final password = _phonePasswordController.text;

    if (phoneNumber.isEmpty || password.isEmpty) {
      _showMessage('Please fill in both fields.', redColor);
      return;
    }

    final url = Uri.parse('$baseUrl/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'phone': phoneNumber,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        _showMessage('Logged in successfully.', greenColor);
        final responseBody = json.decode(response.body);
        final accessToken = responseBody['access_token'] as String?;
        final user = responseBody['user'] as Map<String, dynamic>?;

        if (accessToken == null || user == null) {
          _showMessage('Invalid response from server. Please try again.', redColor);
          return;
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('userId', user['id'] ?? '');
        await prefs.setString('phone', user['phone'] ?? '');
        await prefs.setString('email', user['email'] ?? '');
        await prefs.setString('firstName', user['firstName'] ?? '');
        await prefs.setString('lastName', user['lastName'] ?? '');
        await prefs.setString('profileImage', user['profileImage'] ?? '');

        Get.offAll(() => MainPage());
      } else {
        final responseBody = json.decode(response.body);
        _showMessage(responseBody['message'] ?? 'Login failed. Please try again.', redColor);
      }
    } catch (error, stackTrace) {
      print("Error: $error");
      print("StackTrace: $stackTrace");
      _showMessage('An error occurred. Please check your internet connection and try again.', redColor);
    }
  }



  Future<void> _loginWithEmail() async {
    final email = _emailController.text;
    final password = _emailPasswordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Please fill in both fields.',redColor);
      return;
    }

    final url = Uri.parse('$baseUrl/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        _showMessage('logged in success fully.',greenColor);
        final responseBody = json.decode(response.body);
        final accessToken = responseBody['access_token'] as String?;
        final user = responseBody['user'] as Map<String, dynamic>?;

        if (accessToken == null || user == null) {
          _showMessage('Invalid response from server. Please try again.',redColor);
          return;
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('userId', user['id'] ?? '');
        await prefs.setString('phone', user['phone'] ?? '');
        await prefs.setString('email', user['email'] ?? '');
        await prefs.setString('firstName', user['firstName'] ?? '');
        await prefs.setString('lastName', user['lastName'] ?? '');
        await prefs.setString('profileImage', user['profileImage'] ?? '');

        Get.offAll(() => MainPage());
      } else {
        final responseBody = json.decode(response.body);
        _showMessage(
            responseBody['message'] ?? 'Login failed. Please try again.',redColor);
      }
    } catch (error, stackTrace) {
      print("Error: $error");
      print("StackTrace: $stackTrace");
      _showMessage(
          'An error occurred. Please check your internet connection and try again.',redColor);
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
  bool _isEmailPasswordVisible = false;
  bool _isPhonePasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Login',style: TextStyle(color: primaryTextColor),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 60),
            TabBar(
              controller: _tabController,
              indicatorColor: primaryColor,
              labelColor: primaryColor,
              unselectedLabelColor: greyColor,
              tabs: [
                Tab(text: 'Phone Login'), // Changed position to first
                Tab(text: 'Email Login'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Phone Login Tab (now first)
                  ListView(
                    children: [
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          hintText: 'Enter Phone Number',
                          filled: true,
                          fillColor: Colors.grey[200],
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
                                  Icon(Icons.arrow_drop_down, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _phonePasswordController,
                        decoration: _inputDecoration('Enter Password').copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPhonePasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPhonePasswordVisible = !_isPhonePasswordVisible;
                              });
                            },
                          ),
                        ),
                        obscureText: !_isPhonePasswordVisible,
                      ),
                      SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage()),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32.0),
                      ElevatedButton(
                        onPressed: (){_loginWithPhone();},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          elevation: 5,
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  // Email Login Tab (now second)
                  ListView(
                    children: [
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _emailController,
                        decoration: _inputDecoration('Enter Email'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _emailPasswordController,
                        decoration: _inputDecoration('Enter Password').copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isEmailPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isEmailPasswordVisible = !_isEmailPasswordVisible;
                              });
                            },
                          ),
                        ),
                        obscureText: !_isEmailPasswordVisible,
                      ),
                      SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage()),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32.0),
                      ElevatedButton(
                        onPressed: _loginWithEmail,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          elevation: 5,
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text(
                "Don't have an account? Sign Up Here",
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
    ),
    );
  }

}