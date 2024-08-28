import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:url_launcher/url_launcher.dart';

class InviteAndSharePage extends StatefulWidget {
  @override
  _InviteAndSharePageState createState() => _InviteAndSharePageState();
}

class _InviteAndSharePageState extends State<InviteAndSharePage> {
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future<void> loadContacts() async {
    await requestContactPermission();
    List<Contact> contacts = await fetchContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  Future<void> requestContactPermission() async {
    var status = await Permission.contacts.status;
    if (status.isDenied) {
      await Permission.contacts.request();
    }
  }

  Future<List<Contact>> fetchContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    return _removeDuplicateContacts(contacts.toList());
  }

  List<Contact> _removeDuplicateContacts(List<Contact> contacts) {
    Map<String, Contact> uniqueContacts = {};
    for (var contact in contacts) {
      uniqueContacts[contact.identifier ?? contact.displayName ?? ''] = contact;
    }
    return uniqueContacts.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invite and Share', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
      ),
      body: _contacts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          Contact contact = _contacts[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepOrangeAccent,
                child: Text(
                  contact.displayName != null && contact.displayName!.isNotEmpty
                      ? contact.displayName!.substring(0, 1).toUpperCase()
                      : '?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(contact.displayName ?? 'Unknown'),
              subtitle: contact.phones != null && contact.phones!.isNotEmpty
                  ? Text(contact.phones!.first.value ?? '')
                  : Text('No phone number'),
              onTap: () => _inviteContact(contact),
              trailing: Icon(Icons.send, color: Colors.deepOrange),
            ),
          );
        },
      ),
    );
  }

  void _inviteContact(Contact contact) async {
    if (contact.phones != null && contact.phones!.isNotEmpty) {
      String phoneNumber = contact.phones!.first.value ?? '';
      String message = "Hi ${contact.displayName}, join me on this awesome app on https://play.google.com/store/apps/details?id=-----!";
      _sendSMS(message, phoneNumber);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No phone number available for this contact.")),
      );
    }
  }

  void _sendSMS(String message, String phoneNumber) async {
    String smsUrl = "sms:$phoneNumber?body=${Uri.encodeComponent(message)}";
    if (await canLaunch(smsUrl)) {
      await launch(smsUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not open SMS app.")),
      );
    }
  }
}
