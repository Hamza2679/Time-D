import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InviteAndSharePage extends StatefulWidget {
  @override
  _InviteAndSharePageState createState() => _InviteAndSharePageState();
}

class _InviteAndSharePageState extends State<InviteAndSharePage> {

  Future<void> _sendInvite() async {
    String phoneNumber = '';
    String message = 'Hey, I’m inviting you to join our app!';
    String smsUri = 'sms:$phoneNumber?body=${Uri.encodeComponent(message)}';

    if (await canLaunch(smsUri)) {
      await launch(smsUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Could not open SMS app.'),
      ));
    }
  }


  Future<void> _openContacts() async {
    String contactsUri = 'content://contacts/people/';

    if (await canLaunch(contactsUri)) {
      await launch(contactsUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Could not open Contacts app.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Invite and Share"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _openContacts,
              child: Text('Select Contact'),
            ),
            ElevatedButton(
              onPressed: _sendInvite,
              child: Text('Send Invite'),
            ),
          ],
        ),
      ),
    );
  }
}
