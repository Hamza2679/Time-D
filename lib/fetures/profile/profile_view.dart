import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // If using Firebase Authentication
import 'package:get/get.dart';
import '../../../authentication_repository.dart';
import '../autentication/login/pages/login_page.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? _phoneNumber;

  @override
  void initState() {
    super.initState();
    _fetchPhoneNumber();
  }

  Future<void> _fetchPhoneNumber() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _phoneNumber = user?.phoneNumber ?? 'No phone number';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5.0),
        child: AppBar(
          // title: Text('Hello Delivery',style: TextStyle(fontSize: 5),),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/profile_picture.png'),
              backgroundColor: Colors.orange,
            ),
            SizedBox(height: 10),
            Text(
              'Katty Berry',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone, color: Colors.orange),
                SizedBox(width: 5),
                Text(
                  _phoneNumber ?? 'No phone number',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  ProfileOption(icon: Icons.person, title: 'My Profile'),
                  ProfileOption(icon: Icons.receipt, title: 'My Orders'),
                  ProfileOption(icon: Icons.location_on, title: 'Delivery Address'),
                  ProfileOption(icon: Icons.payment, title: 'Payment Methods'),
                  ProfileOption(icon: Icons.mail, title: 'Contact Us'),
                  ProfileOption(icon: Icons.settings, title: 'Settings'),
                  ProfileOption(icon: Icons.help, title: 'Help & FAQ'),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.orange,
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.orange),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: Icon(Icons.logout, color: Colors.orange),
              label: Text(
                'Log out',
                style: TextStyle(color: Colors.orange),
              ),
              onPressed: () async {
                await AuthenticationRepository.instance.logout();
                Get.offAll(() => LoginPage());
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileOption({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title),
      onTap: () {
        // Handle option tap
      },
    );
  }
}
