import 'package:hive/hive.dart';
import '../models/user_profile_model.dart';

class UserLocalStorage {
  static Box<dynamic> get _box => Hive.box('userBox');

  static Future<void> saveUser(UserProfileModel user) async {
    await _box.put('userData', user.toJson());  }

  static UserProfileModel? getUser() {
    final data = _box.get('userData');
    if (data != null) {
      return UserProfileModel.fromJson(Map<String, dynamic>.from(data));
    }
    return null;
  }
  static Future<void> clearUser() async {
    final box = Hive.box('userBox');
    await box.delete('userData');
  }


  static bool isLoggedIn() {
    return _box.containsKey('userData');
  }
}
