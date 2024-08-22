import 'package:delivery_app/fetures/home/pages/main_page.dart';
import 'package:delivery_app/fetures/order/order_view.dart';
import 'package:delivery_app/fetures/profile/options/contact_us/contact_us_page.dart';
import 'package:delivery_app/fetures/profile/options/help_and_faq/help.dart';
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
          preferredSize: Size.fromHeight(5.0),
          child: AppBar(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/profile_picture.jpg'),
                backgroundColor: Colors.orange,
              ),
              SizedBox(height: 10),
              Text(
                'Update your name',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoaded) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone, color: Colors.orange),
                        SizedBox(width: 5),
                        Text(
                          state.phoneNumber,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
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
              SizedBox(height: 30),
              Expanded(
                child: ListView(
                  children: [
                    ProfileOption(
                      icon: Icons.person,
                      title: 'Edit Profile',
                      onTap: () {
                        Get.to(() => EditProfileView());
                      },
                    ),
                    ProfileOption(icon: Icons.receipt, title: 'My Orders' ,  onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderView()),

                      );
                    },),
                    ProfileOption(icon: Icons.location_on, title: 'Delivery Address', onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Your delivery address is"),
                            content: Text("street:____  ,block:___   home:____ "),
                            actions: <Widget>[
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => ProfileView()),
                                        (Route<dynamic> route) => false,
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },),
                    ProfileOption(icon: Icons.share, title: 'Invite and Share' , onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InviteAndSharePage()),
                      );
                    },),
                    ProfileOption(icon: Icons.payment, title: 'Payment Methods'),
                    ProfileOption(icon: Icons.mail, title: 'Contact Us' , onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContactUsPage())
                      );
                    },),
                    ProfileOption(icon: Icons.settings, title: 'Settings'),
                    ProfileOption(icon: Icons.help, title: 'Help & FAQ', onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HelpFaqPage())
              );
              },),
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
      leading: Icon(icon, color: Colors.orange),
      title: Text(title),
      onTap: onTap,
    );
  }
}
