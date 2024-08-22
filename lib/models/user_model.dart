// user_model.dart
import 'dart:io';

class UserModel {
  final File? profileImage;
  final String fullName;
  final String phoneNumber;

  UserModel({
    required this.profileImage,
    required this.fullName,
    required this.phoneNumber,
  });

  // Method to copy the UserModel with updated fields
  UserModel copyWith({
    File? profileImage,
    String? fullName,
    String? phoneNumber,
  }) {
    return UserModel(
      profileImage: profileImage ?? this.profileImage,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  // Factory method to create a UserModel from a map (useful for storage)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      profileImage: map['profileImage'] != null ? File(map['profileImage']) : null,
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
    );
  }

  // Method to convert UserModel to a map (useful for storage)
  Map<String, dynamic> toMap() {
    return {
      'profileImage': profileImage?.path,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
    };
  }
}
