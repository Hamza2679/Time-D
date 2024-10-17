import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/colors.dart';

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
    return _removeDuplicateContacts(
        contacts.where((contact) => _hasValidPhoneNumber(contact)).toList());
  }

  bool _hasValidPhoneNumber(Contact contact) {
    if (contact.phones == null || contact.phones!.isEmpty) return false;

    return contact.phones!.any((phone) {
      final phoneNumber = phone.value?.replaceAll(RegExp(r'\s+'), '') ?? '';
      return phoneNumber.startsWith('09') ||
          phoneNumber.startsWith('07') ||
          phoneNumber.startsWith('+251');
    });
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            image: DecorationImage(
              image: AssetImage('assets/appicon.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2),
                BlendMode.dstATop,
              ),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Invite and Share',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryTextColor,
              ),
            ),
          ),
        ),
      ),
      body: _contacts.isEmpty
          ? Center(child: CircularProgressIndicator(color: primaryColor,))
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
                backgroundColor: secondaryColor,
                child: Text(
                  contact.displayName != null && contact.displayName!.isNotEmpty
                      ? contact.displayName!.substring(0, 1).toUpperCase()
                      : '?',
                  style: TextStyle(color: primaryTextColor),
                ),
              ),
              title: Text(contact.displayName ?? 'Unknown'),
              subtitle: contact.phones != null && contact.phones!.isNotEmpty
                  ? Text(contact.phones!.first.value ?? '')
                  : Text('No phone number'),
              onTap: () => inviteContact(contact),
              trailing: Icon(Icons.send, color: primaryColor),
            ),
          );
        },
      ),
    );
  }

  void inviteContact(Contact contact) async {
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
