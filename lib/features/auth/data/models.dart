
import '../domain/entities.dart';

class UserModel extends UserEntity {
  final String token;

  UserModel({
    required this.token,
    required String id,
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String name,
    required String phone,
  }) : super(
    id: id,
    username: username,
    email: email,
    name: name,
    firstName: firstName,
    lastName: lastName,
    phone: phone,
    token: token,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};

    return UserModel(
      id: user['id']?.toString() ?? "",
      username: user['username'] ?? "",
      email: user['email'] ?? "",
      name: '${user['firstName'] ?? ""} ${user['lastName'] ?? ""}',
      phone: user['phone'] ?? "",
      token: json['token'] ?? "",
      firstName: user['firstName'] ?? "",
      lastName: user['lastName'] ?? "",
    );
  }

}
