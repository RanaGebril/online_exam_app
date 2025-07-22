import '../../../auth/data/models.dart';

class UserProfileModel {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  UserProfileModel({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  factory UserProfileModel.fromUserModel(UserModel user) {
    return UserProfileModel(
      username: user.username,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      phone: user.phone,
    );
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
    };
  }
}
