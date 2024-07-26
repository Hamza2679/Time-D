import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LoginPage extends StatelessWidget {
  final List<String> _countryCodes = ['+1', '+91', '+44', '+61', '+81', '+49', '+251'];
  final TextEditingController _phoneNumberController = TextEditingController();
  String? _selectedCountryCode = '+251';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Login', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                'Hello Delivery',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 50),
              Text(
                'Enter your phone number to login',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                      value: _selectedCountryCode,
                      items: _countryCodes.map((String code) {
                        return DropdownMenuItem<String>(
                          value: code,
                          child: Text(code),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        context.read<LoginBloc>().add(CountryCodeChanged(newValue!));
                        _selectedCountryCode = newValue;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        context.read<LoginBloc>().add(PhoneNumberChanged(value));
                      },
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to verify phone number: ${state.error}')),
                      );
                    }
                    if (state is LoginSuccess) {
                      // Handle success navigation or logic here
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                      ),
                      onPressed: () {
                        context.read<LoginBloc>().add(SubmitPhoneNumber(context));
                      },
                      child: Text('Submit', style: TextStyle(color: Colors.white)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
