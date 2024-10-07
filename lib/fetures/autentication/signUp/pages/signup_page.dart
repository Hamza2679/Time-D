import 'dart:convert';
import 'package:delivery_app/fetures/autentication/login/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:permission_handler/permission_handler.dart'; // For permission handling

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  File? profileImage;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController _passwordController = TextEditingController(); // Password controller
  final TextEditingController _confirmPasswordController = TextEditingController(); // Confirm password controller
  final TextEditingController _phoneNumberController = TextEditingController();
  String _selectedCountryCode = '+251'; // Default country code (Ethiopia)
  String _countryFlag = '🇪🇹'; // Default country flag (Ethiopia)
  final String baseUrl = 'https://hello-delivery.onrender.com/api/v1';

  Future<void> _pickImage() async {
    // Check permission for gallery access
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      await Permission.photos.request();
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Select from Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedFile =
                  await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      profileImage = File(pickedFile.path);
                    });
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Picture'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedFile =
                  await _picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      profileImage = File(pickedFile.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  InputDecoration _inputDecoration(String hintText, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
      suffixIcon: suffixIcon, // Add suffix icon for password fields
    );
  }



  Future<void> _register() async {
    if (!_formKey.currentState!.validate() || profileImage == null) {
      return;
    }

    _formKey.currentState!.save();

    final url = Uri.parse('$baseUrl/auth/register');
    final request = http.MultipartRequest('POST', url);

    // Add fields as form data
    request.fields['firstName'] = firstName!;
    request.fields['lastName'] = lastName!;
    request.fields['email'] = email!;
    request.fields['password'] = _passwordController.text; // Use controller text
    request.fields['phone'] = '$_selectedCountryCode ${_phoneNumberController.text}';

    // Convert profile image to base64 and add it as a form field
    if (profileImage != null) {
      final bytes = await File(profileImage!.path).readAsBytes();
      final base64Image = base64Encode(bytes);
      final mimeType = 'image/${profileImage!.path.split('.').last}';
      request.fields['profileImage'] = 'data:$mimeType;base64,$base64Image';
    }

    // Print request details for debugging
    print('Request URL: ${request.url}');
    print('Request Method: ${request.method}');
    print('Request Headers: ${request.headers}');
    print('Request Fields: ${request.fields}');

    try {
      // Send the request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      // Print response details for debugging
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: $responseBody');

      if (response.statusCode == 201) {
        _showMessage('Registered successfully', Colors.green);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        final responseData = json.decode(responseBody);
        _showMessage(responseData['message'] ?? 'Registration failed. Please try again.', Colors.red);
      }
    } catch (error) {
      // Print error details for debugging
      print('Error: $error');
      _showMessage('An error occurred. Please check your internet connection and try again.', Colors.red);
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
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200], // Add a background color
                  child: ClipOval(
                    child: profileImage != null
                        ? Image.file(
                      profileImage!,
                      width: 100, // Make sure the image fits within the avatar
                      height: 100,
                      fit: BoxFit.cover,
                    )
                        : Icon(Icons.add_a_photo, size: 50),
                  ),
                ),
              ),

              SizedBox(height: 16.0),
              TextFormField(
                decoration: _inputDecoration('First Name'),
                onSaved: (value) => firstName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: _inputDecoration('Last Name'),
                onSaved: (value) => lastName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: _inputDecoration('Email'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => email = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              // Password field with eye icon
              TextFormField(
                controller: _passwordController, // Use controller
                decoration: _inputDecoration(
                  'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              // Confirm password field with eye icon
              TextFormField(
                controller: _confirmPasswordController, // Use controller
                decoration: _inputDecoration(
                  'Confirm Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscureConfirmPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _register,
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
