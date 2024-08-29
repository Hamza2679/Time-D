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

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      profileImage: map['profileImage'] != null ? File(map['profileImage']) : null,
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profileImage': profileImage?.path,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
    };
  }
}
