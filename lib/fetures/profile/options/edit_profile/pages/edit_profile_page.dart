import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EditProfileView extends StatefulWidget {
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  File? _profileImage;
  LatLng? _selectedLocation;
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _fullNameController.text = _prefs?.getString('fullName') ?? '';
      _addressController.text = _prefs?.getString('address') ?? '';
      String? profileImagePath = _prefs?.getString('profileImage');
      if (profileImagePath != null) {
        _profileImage = File(profileImagePath);
      }
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void _removeImage() async {
    setState(() {
      _profileImage = null;
    });
    await _prefs?.remove('profileImage');
  }

  Future<void> _fetchCurrentLocation() async {
    LatLng simulatedLocation = LatLng(9.025, 38.7469);
    setState(() {
      _selectedLocation = simulatedLocation;
      _addressController.text = 'Current Address: (${simulatedLocation.latitude}, ${simulatedLocation.longitude})';
    });
  }

  Future<void> saveProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      await _prefs?.setString('fullName', _fullNameController.text);
      await _prefs?.setString('address', _addressController.text);
      if (_profileImage != null) {
        await _prefs?.setString('profileImage', _profileImage!.path);
      } else {
        await _prefs?.remove('profileImage');
      }
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Select profile",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    _showImageSourceSelection(context);
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? Icon(Icons.camera_alt, size: 40, color: Colors.black)
                        : null,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.location_on_rounded,
                          color: Colors.deepOrange),
                      onPressed: _fetchCurrentLocation,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepOrange,
                  ),
                  onPressed: () {
                    saveProfile();
                  },
                  child: Text("Save Profile"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImageSourceSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              if (_profileImage != null)
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Remove'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _removeImage();
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
