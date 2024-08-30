import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart' as permissionHandler;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


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

  String? _phoneNumber;
  @override
  void initState() {
    super.initState();
    requestPermissions();
    _fetchPhoneNumber();

  }

  Future<void> _fetchPhoneNumber() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _phoneNumber = user?.phoneNumber ?? 'No phone number';
    });
  }
  Future<void> requestPermissions() async {
    await permissionHandler.Permission.camera.request();
    await permissionHandler.Permission.storage.request();
    await permissionHandler.Permission.location.request();
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

  void _openMap() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MapSelectionScreen(
          initialLocation: _selectedLocation,
        ),
      ),
    );

    if (result != null && result is LatLng) {
      setState(() {
        _selectedLocation = result;
        _addressController.text =
        'Lat: ${result.latitude}, Lng: ${result.longitude}';
      });
    }
  }

  void saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.deepOrange,
        title: Text('Edit Profile' ,style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Form(

          key: _formKey,
          child: SingleChildScrollView(
            child: Column(

              children: [
                Text("Select profile",
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
                        ? Icon(Icons.camera_alt, size: 40,color: Colors.black,)
                        : null,
                  ),

                ),

                SizedBox(height: 20),

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
                      icon: Icon(Icons.location_on_rounded , color: Colors.deepOrange),
                      onPressed: _openMap,
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
                    backgroundColor: Colors.deepOrange, // Text color
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
            ],
          ),
        );
      },
    );
  }
}

class MapSelectionScreen extends StatelessWidget {
  final LatLng? initialLocation;

  MapSelectionScreen({this.initialLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: initialLocation ?? LatLng(0, 0),  // Set initial map center
          zoom: 13.0,
          onTap: (tapPosition, point) {
            Navigator.of(context).pop(point);
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          if (initialLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: initialLocation!,
                  builder: (ctx) =>
                      Icon(Icons.location_on, color: Colors.red),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
