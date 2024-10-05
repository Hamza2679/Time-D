import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/authentication_repository.dart';
import '../../autentication/login/pages/login_page.dart';
import '../bloc/profile_bloc.dart';
import '../options/edit_profile/pages/edit_profile_page.dart';
import '../options/invite/invite.dart';
import '../options/contact_us/contact_us_page.dart';
import '../options/help_and_faq/help.dart';
import '../options/payment/payment.dart';
import '../options/setting/setting.dart';
import '../../order/order_view.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String fullName = 'Update your name';
  String phoneNumber = '';
  ImageProvider? profileImage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    final firstName = prefs.getString('firstName') ?? 'Update';
    final lastName = prefs.getString('lastName') ?? 'your name';
    final updatedPhone = prefs.getString('phone') ?? '';

    final profileImageUrl = prefs.getString('profileImageUrl');

    setState(() {
      fullName = '$firstName $lastName';
      phoneNumber = updatedPhone;
      if (profileImageUrl != null && profileImageUrl.isNotEmpty) {
        profileImage = NetworkImage(profileImageUrl);
      } else {
        profileImage = AssetImage('assets/profile_picture.jpg');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(FetchPhoneNumber()),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: profileImage,
                        backgroundColor: Colors.deepOrange,
                      ),
                      SizedBox(height: 15),
                      Text(
                        fullName,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange[800],
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone, color: Colors.deepOrange[600]),
                          SizedBox(width: 5),
                          Text(
                            phoneNumber,
                            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(15),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView(
                      children: [
                        ProfileOption(
                          icon: Icons.share,
                          title: 'Invite and Share',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => InviteAndSharePage()));
                          },
                        ),
                        ProfileOption(
                          icon: Icons.person,
                          title: 'Edit Profile',
                          onTap: () async {
                            final result = await Get.to(() => EditProfileView());
                            if (result == true) {
                              _loadProfileData();
                            }
                          },
                        ),
                        ProfileOption(
                          icon: Icons.help,
                          title: 'Help & FAQ',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HelpFaqPage()));
                          },
                        ),
                        ProfileOption(
                          icon: Icons.receipt,
                          title: 'My Orders',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OrderView()));
                          },
                        ),
                        ProfileOption(
                          icon: Icons.location_on,
                          title: 'Delivery Address',
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "Your delivery address is",
                                    style: TextStyle(
                                      color: Colors.deepOrange[800],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Text(
                                    "Street:____, Block:___, Home:____",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        ProfileOption(
                          icon: Icons.payment,
                          title: 'Payment Methods',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Payment()));
                          },
                        ),
                        ProfileOption(
                          icon: Icons.mail,
                          title: 'Contact Us',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsPage()));
                          },
                        ),
                        ProfileOption(
                          icon: Icons.settings,
                          title: 'Settings',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Setting()));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepOrange,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text(
                  'Log out',
                  style: TextStyle(color: Colors.white),
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
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const ProfileOption({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepOrange),
      title: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepOrange),
      onTap: onTap,
    );
  }
}
