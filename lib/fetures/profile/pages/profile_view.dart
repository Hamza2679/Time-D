import 'package:delivery_app/fetures/order/order_view.dart';
import 'package:delivery_app/fetures/profile/options/contact_us/contact_us_page.dart';
import 'package:delivery_app/fetures/profile/options/help_and_faq/help.dart';
import 'package:delivery_app/fetures/profile/options/payment/payment.dart';
import 'package:delivery_app/fetures/profile/options/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../authentication_repository.dart';
import '../../autentication/login/pages/login_page.dart';
import '../bloc/profile_bloc.dart';
import '../options/edit_profile/pages/edit_profile_page.dart';
import '../options/invite/invite.dart';

class ProfileView extends StatelessWidget {
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
                        backgroundImage: AssetImage('assets/profile_picture.jpg'),
                        backgroundColor: Colors.deepOrange,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Update your name',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange[800],
                        ),
                      ),
                      SizedBox(height: 8),
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileLoaded) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.phone, color: Colors.deepOrange[600]),
                                SizedBox(width: 5),
                                Text(
                                  state.phoneNumber,
                                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                ),
                              ],
                            );
                          } else if (state is ProfileError) {
                            return Text(
                              state.message,
                              style: TextStyle(color: Colors.red),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InviteAndSharePage()),
                            );
                          },
                        ),
                        ProfileOption(
                          icon: Icons.person,
                          title: 'Edit Profile',
                          onTap: () {
                            Get.to(() => EditProfileView());
                          },
                        ),
                        ProfileOption(
                          icon: Icons.help,
                          title: 'Help & FAQ',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HelpFaqPage()),
                            );
                          },
                        ),
                        ProfileOption(
                          icon: Icons.receipt,
                          title: 'My Orders',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OrderView()),
                            );
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
                                    "Street:____, /t Block:___, Home:____",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.pop(
                                          context,

                                        );
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Payment()));
                          },
                        ),
                        ProfileOption(
                          icon: Icons.mail,
                          title: 'Contact Us',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactUsPage()));
                          },
                        ),
                        ProfileOption(
                          icon: Icons.settings,
                          title: 'Settings',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Setting()));
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
