import 'package:flutter/material.dart';

class HelpFaqPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Help & FAQ', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _buildFAQItem(
              'How do I reset my password?',
              'We are using only otp to verify a user, you can logout from the app by  go to the profile screen and tap on "logout button". Follow the instructions to login again.',
            ),
            _buildFAQItem(
              'How do I contact support?',
              'You can contact support by visiting the Contact Us page or emailing support@yourapp.com.',
            ),
            _buildFAQItem(
              'Where can I find the latest updates?',
              'The latest updates are available on the Updates page in the app or on our website.',
            ),
            _buildFAQItem(
              'How do I delete my account?',
              'To delete your account, go to the settings page and select "Delete Account". Follow the instructions provided.',
            ),
            _buildFAQItem(
              'How do I reset my password?',
              'We are using only otp to verify a user, you can logout from the app by  go to the profile screen and tap on "logout button". Follow the instructions to login again.',
            ),
            _buildFAQItem(
              'How do I contact support?',
              'You can contact support by visiting the Contact Us page or emailing support@yourapp.com.',
            ),
            _buildFAQItem(
              'Where can I find the latest updates?',
              'The latest updates are available on the Updates page in the app or on our website.',
            ),
            _buildFAQItem(
              'How do I delete my account?',
              'To delete your account, go to the settings page and select "Delete Account". Follow the instructions provided.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(answer),
          ),
        ],
      ),
    );
  }
}
